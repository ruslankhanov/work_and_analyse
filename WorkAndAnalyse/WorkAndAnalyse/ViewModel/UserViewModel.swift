//
//  UserModelView.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 02.03.2021.
//

import UIKit

class UserViewModel {
    
    //var onFinish: (() -> Void)?
    
    private let registrationService = RegistrationService()
    private let loginService = LoginService()
    
    func register(email: String, username: String, password: String, passwordConfirmation: String, completion: @escaping ((_ error: String) -> Void)) {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPasswordConfirmation = passwordConfirmation.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let user = User(email: cleanEmail, password: cleanPassword, username: cleanUsername)
        
        registrationService.signUp(user: user, passwordConfirmation: cleanPasswordConfirmation) { result in
            switch result {
            case .failure(let error):
                print(error)
                return completion(error.localizedDescription)
            case .success(()):
                return completion("Success")
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping ((_ error: String) -> Void)) {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        loginService.signIn(email: cleanEmail, password: cleanPassword) { result in
            switch result {
            case .failure(let error):
                print(error)
                return completion(error.localizedDescription)
            case .success(()):
                return completion("Success")
            }
        }
    }
}
