//
//  AppCoordinator.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 16.03.2021.
//
import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        // TODO: check if user is signed in
        if Auth.auth().currentUser != nil {
            print("Hi, user!")
        } else {
            authorizationFlow()
        }
    }
    
    func authorizationFlow() {
        let child = SignInCoordinator(navigationController: navigationController)
        child.parentCoordinator = self

        childCoordinators.append(child)
        child.start()
    }
    
    func mainFlow() {
        // TODO: main flow logic
    }
    
}
