//
//  SettingsViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import Foundation

protocol SettingsViewModelProtocol {
    var dataToPresent: [TitledClosure]! { get set }
}

protocol SettingsViewModelDelegate: class {
}

class SettingsViewModel: SettingsViewModelProtocol {
    var dataToPresent: [TitledClosure]!
    
    weak var delegate: SettingsViewModelDelegate?
    
    private let loginService: LoginService
    private let taskService: TaskService
    
    init(loginService: LoginService, taskService: TaskService) {
        self.loginService = loginService
        self.taskService = taskService
        loadData()
    }
    
    private func loadData() {
        dataToPresent = [
            TitledClosure(title: "Clear all data (WARNING)") { [weak self] in
                self?.taskService.clearData() { (error) in
                    guard error == nil else {
                        print(error.debugDescription)
                        return
                    }
                }
            },
            TitledClosure(title: "Sign out") { [weak self] in
                self?.loginService.signOut() { (error) in
                    guard error == nil else {
                        print(error.debugDescription)
                        return
                    }
                    
                    self?.postNotification()
                }
            }
        ]
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: .didSignOut, object: nil)
    }
}
