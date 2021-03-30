//
//  MainCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 07.03.2021.
//

import UIKit

class AuthCoordinator: BaseCoordinator, AuthCoordinatorFinishOutput {
    
    // MARK: - AuthCoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        showSignInViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods
    private func showSignInViewController() {
        let viewController = viewControllerFactory.instantiateSignInViewController()
        
        viewController.viewModel.signUpAction = { [unowned self] in
            self.showSignUpViewController()
        }
        
        viewController.viewModel.finishSignIn = { [weak self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully signed in.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.finishFlow?()
            }
        }
        
        viewController.viewModel.failSignIn = { [weak viewController] message in
            viewController?.showAlert(title: "Error", message: message)
        }
        
        router.setRootModule(viewController, hideBar: false)
    }
    
    private func showSignUpViewController() {
        let viewController = viewControllerFactory.instantiateSignUpViewController()

        viewController.viewModel.finishSignUp = { [unowned self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully created your account.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.finishFlow?()
            }
        }
        
        viewController.viewModel.failSignUp = { [weak viewController] message in
            viewController?.showAlert(title: "Error", message: message)
        }
        
        router.push(viewController)
    }
}
