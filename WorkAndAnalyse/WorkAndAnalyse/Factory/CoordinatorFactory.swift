//
//  CoordinatorFactory.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
    
    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (TaskCreationCoordinator, UINavigationController)
    
    func makeMyTasksCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (MyTasksCoordinator, UINavigationController)
    
    func makeCompletedTasksCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (CompletedTasksCoordinator, UINavigationController)
    
    func makeSettingsCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (SettingsCoordinator, UINavigationController)
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {

    // MARK: - CoordinatorFactoryProtocol

    func makeTaskCreationCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (TaskCreationCoordinator, UINavigationController) {
        let coordinator = TaskCreationCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, navigationController)
    }
    
    func makeAuthCoordinator(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeMyTasksCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (MyTasksCoordinator, UINavigationController) {
        let coordinator = MyTasksCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, navigationController)
    }
    
    func makeCompletedTasksCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (CompletedTasksCoordinator, UINavigationController) {
        let coordinator = CompletedTasksCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, navigationController)
    }
    
    func makeSettingsCoordinator(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> (SettingsCoordinator, UINavigationController) {
        let coordinator = SettingsCoordinator(router: Router(rootController: navigationController), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return (coordinator, navigationController)
    }
}
