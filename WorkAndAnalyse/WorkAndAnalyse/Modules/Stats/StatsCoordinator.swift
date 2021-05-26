//
//  StatsCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import UIKit

class StatsCoordinator: BaseCoordinator {
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    override func start() {
        showSettingsController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Private methods
    
    private func showSettingsController() {
        let viewController = viewControllerFactory.instantiateStatsViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.bar.xaxis"), tag: 3)
        viewController.navigationItem.title = "Stats"
        
        let viewModel = StatsViewModel(taskService: TaskServiceImplementation.shared)
        viewModel.delegate = viewController
        
        viewController.viewModel = viewModel
        router.setRootModule(viewController)
    }
}
