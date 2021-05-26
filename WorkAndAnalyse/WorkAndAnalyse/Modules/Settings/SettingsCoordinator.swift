//
//  SettingsCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import UIKit

class SettingsCoordinator: BaseCoordinator {
    
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
        let viewController = viewControllerFactory.instantiateSettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), tag: 3)
        viewController.navigationItem.title = "Settings"
        
        let viewModel = SettingsViewModel(loginService: FirebaseLoginService.shared, taskService: TaskServiceImplementation.shared)
        viewModel.delegate = viewController
        
        viewController.viewModel = viewModel
        router.setRootModule(viewController)
    }
}
