//
//  ViewControllerFactory.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import UIKit

class ViewControllerFactory {
    func instantiateSignInViewController() -> SignInViewController {
        let viewController = SignInViewController()
        viewController.viewModel = SignInViewModel(loginService: LoginService())
        return viewController
    }

    func instantiateSignUpViewController() -> SignUpViewController {
        let viewController = SignUpViewController()
        viewController.viewModel = SignUpViewModel(registrationService: RegistrationService())
        return viewController
    }
    
    func instantiateCreateTaskViewController() -> CreateTaskViewController {
        let viewController = CreateTaskViewController()
        return viewController
    }
    
    func instantiateMainTabBarController() -> MainTabBarController {
        let tabBarController = MainTabBarController()
        return tabBarController
    }
    /*
    func instantiateCreatSubtaskViewController() -> CreateSubtaskViewController {
        let viewController = CreateSubtaskViewController()
        return viewController
    }
    */
}
