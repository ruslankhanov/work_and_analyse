//
//  MainTabBarController.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 29.03.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate, MainTabBarViewOutput {
    
    
    // MARK: - MainTabBarViewOutput
    
    var onTaskCreationFlowSelect: ((UINavigationController) -> ())?
    
    var onViewDidLoad: ((UINavigationController) -> ())?
    
    // MARK: - Vars & Lets
    
    var itemsCount: Int = 2
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        viewControllers = [UINavigationController()]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let controller = viewControllers?.first as? UINavigationController {
            onViewDidLoad?(controller)
        }
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        if selectedIndex == 0 {
            onTaskCreationFlowSelect?(controller)
        }
    }
}
