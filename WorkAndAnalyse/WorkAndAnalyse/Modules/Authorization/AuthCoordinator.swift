//
//  MainCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 07.03.2021.
//

import UIKit

class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
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
        
        let viewModel = SignInViewModel(loginService: FirebaseLoginService.shared)
        
        viewController.onGoToSignUp = { [unowned self] in
            self.showSignUpViewController()
        }
        
        viewModel.finishSignIn = { [weak self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully signed in.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.finishFlow?()
            }
        }
        
        viewModel.failSignIn = { [weak viewController] message in
            viewController?.showAlert(title: "Error", message: message)
        }
        
        viewController.viewModel = viewModel
        
        router.setRootModule(viewController, hideBar: false)
    }
    
    private func showSignUpViewController() {
        let viewController = viewControllerFactory.instantiateSignUpViewController()
        
        let viewModel = SignUpViewModel(registrationService: FirebaseRegistrationService.shared)

        viewModel.finishSignUp = { [unowned self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully created your account.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.finishFlow?()
            }
        }
        
        viewModel.failSignUp = { [weak viewController] message in
            viewController?.showAlert(title: "Error", message: message)
        }
        
        viewController.viewModel = viewModel
        
        router.push(viewController)
    }
}
