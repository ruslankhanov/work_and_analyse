//
//  ApplicationCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Vars & Lets
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor = LaunchInstructor.configure()
    private let viewControllerFactory: ViewControllerFactory = ViewControllerFactory()
    
    // MARK: - Coordinator
    
    override func start() {
        switch launchInstructor {
        case .auth:
            runAuthFlow()
        case .main:
            runMainFlow()
        return
        }
    }
    
    // MARK: - Init
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    // MARK: - Private methods
    
    private func runAuthFlow() {
        let coordinator = self.coordinatorFactory.makeAuthCoordinator(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure()
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let module = viewControllerFactory.instantiateMainTabBarController(coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        router.setRootModule(module, hideBar: true)
    }
}
