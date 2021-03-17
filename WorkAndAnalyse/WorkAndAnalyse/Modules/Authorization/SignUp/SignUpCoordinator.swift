//
//  SignUpCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 07.03.2021.
//

import UIKit

class SignUpCoordinator: Coordinator {

    weak var parentCoordinator: SignInCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(signUpViewController(), animated: true)
    }
    
    private func signUpViewController() -> UIViewController {
        let viewController = SignUpViewController.instantiate()
        
        let viewModel = SignUpViewModel(registrationService: RegistrationService())
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController.self
        
        viewController.finishSignUp = { [weak self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully created your account")
            self?.didFinish()
        }
        
        viewController.failSignUp = { [weak viewController] message in
            
            viewController?.showAlert(title: "Error", message: message)
        }
        
        return viewController
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController.popViewController(animated: true)
        }
    }
}
