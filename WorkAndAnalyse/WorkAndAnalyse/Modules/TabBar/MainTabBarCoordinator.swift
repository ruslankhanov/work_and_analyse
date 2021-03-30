//
//  MainTabBarCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 29.03.2021.
//

import UIKit

class MainTabBarCoordinator: BaseCoordinator {
    
    // MARK: - Vars & Lets

    private var viewOutput: MainTabBarViewOutput
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Init
    
    init(viewOutput: MainTabBarViewOutput, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.viewOutput = viewOutput
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Coordinator

    override func start() {
        viewOutput.onViewDidLoad = runTaskCreationFlow()
        viewOutput.onTaskCreationFlowSelect = runTaskCreationFlow()
    }
    
    // MARK: - Private methods
    
    private func runTaskCreationFlow() -> ((UINavigationController) -> ()) {
        return { [unowned self] navigationController in
            if navigationController.viewControllers.isEmpty == true {
                let taskCreationCoordinator = self.coordinatorFactory.makeTaskCreationCoordinator(navigationController: navigationController, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
                self.addDependency(taskCreationCoordinator)
                taskCreationCoordinator.start()
            }
        }
    }
}
