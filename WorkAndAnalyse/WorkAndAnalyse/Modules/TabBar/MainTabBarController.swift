//
//  MainTabBarController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 29.03.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Vars & Lets
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    private var coordinators: [(Coordinator, UINavigationController)] = []
    
    
    // MARK: - Init
    
    init(coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinators = [
            coordinatorFactory.makeTaskCreationCoordinator(navigationController: UINavigationController(), coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        ]
        
        coordinators.forEach {
            $0.0.start()
        }
                
        viewControllers = coordinators.map { $0.1 }
    }
}
