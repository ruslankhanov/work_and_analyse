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
        return viewController
    }

    func instantiateSignUpViewController() -> SignUpViewController {
        let viewController = SignUpViewController()
        return viewController
    }
    
    func instantiateCreateTaskViewController() -> CreateTaskViewController {
        let viewController = CreateTaskViewController()
        return viewController
    }
    
    func instantiateMainTabBarController(coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> MainTabBarController {
        let tabBarController = MainTabBarController(coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return tabBarController
    }
    
    func instantiateAddSubtaskViewController() -> AddSubtaskViewController {
        let viewController = AddSubtaskViewController()
        return viewController
    }
    
    func instantiateTaskListViewController() -> TaskListViewController {
        let viewController = TaskListViewController()
        return viewController
    }
    
    func instantiateSettingsViewController() -> SettingsViewController {
        let viewController = SettingsViewController()
        return viewController
    }
}
