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
        viewController.tabBarItem = UITabBarItem(title: "Create task", image: UIImage(systemName: "plus"), tag: 0)
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
    
    func instantiateMyTasksViewController() -> MyTasksViewController {
        let viewController = MyTasksViewController()
        viewController.tabBarItem = UITabBarItem(title: "My tasks", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        return viewController
    }
    
}
