//
//  MainCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 07.03.2021.
//

import UIKit

class SignInCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(signInViewController(), animated: true)
    }
    
    private func signInViewController() -> UIViewController {
        let viewController = SignInViewController.instantiate()
        let viewModel = SignInViewModel(loginService: LoginService())
        
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        
        viewController.signUpAction = { [weak self] in
            self?.signUp()
        }
        
        viewController.finishSignIn = { [weak self, weak viewController] in
            viewController?.showAlert(title: "Success", message: "You've successfully signed in.")
            self?.didFinish()
        }
        
        viewController.failSignIn = { [weak viewController] message in
            viewController?.showAlert(title: "Error", message: message)
        }
        
        return viewController
    }
    
    func signUp() {
        let child = SignUpCoordinator(navigationController: navigationController)
        child.parentCoordinator = self

        childCoordinators.append(child)
        child.start()
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController.popViewController(animated: true)
        }
    }
}
