//
//  SettingsViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

import Foundation

protocol SettingsViewModelProtocol {
    var dataToPresent: [SettingElementViewModel]! { get set }
}

protocol SettingsViewModelDelegate: class {
    func showAlert(title: String, message: String)
}

class SettingsViewModel: SettingsViewModelProtocol {
    var dataToPresent: [SettingElementViewModel]!
    
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
            SettingElementViewModel(title: "Clear all data", isEnabled: true) { [weak self] in
                //self?.delegate?.showAlert(title: "", message: <#T##String#>)
                self?.taskService.clearData() { (error) in
                    guard error == nil else {
                        print(error.debugDescription)
                        return
                    }
                }
            },
            SettingElementViewModel(title: "Sign out", isEnabled: true) { [weak self] in
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
