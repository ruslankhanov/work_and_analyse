//
//  CoordinatorFactory.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
    
    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> TaskCreationCoordinator
    
    func makeMainTabBarCoordinator(coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (coordinator: MainTabBarCoordinator, toPresent: Presentable?)
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - CoordinatorFactoryProtocol

    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> TaskCreationCoordinator {
        let coordinator = TaskCreationCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeMainTabBarCoordinator(coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (coordinator: MainTabBarCoordinator, toPresent: Presentable?) {
        let controller = viewControllerFactory.instantiateMainTabBarController()
        let coordinator = MainTabBarCoordinator(viewOutput: controller as MainTabBarViewOutput, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, controller)
    }
}
