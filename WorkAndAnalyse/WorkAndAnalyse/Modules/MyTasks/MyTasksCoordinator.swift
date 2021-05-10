//
//  MyTasksCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import Foundation

class MyTasksCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - Vars & Lets
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        showMyTasksViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods
    
    private func showMyTasksViewController() {
        let viewController = viewControllerFactory.instantiateMyTasksViewController()
        router.setRootModule(viewController)
    }
}
