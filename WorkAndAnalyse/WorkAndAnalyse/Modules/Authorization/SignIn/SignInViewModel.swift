//
//  SignInViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 16.03.2021.
//

protocol SignInDelegate: AnyObject {
    func didSignIn()
    func didFailSignIn(message: String)
}

class SignInViewModel {
    private let loginService: LoginService
    weak var delegate: SignInDelegate?
    
    var email = ""
    var password = ""
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func signInTap() {
        loginService.signIn(email: email, password: password) { [weak self] response in
            switch response {
            case .failure(let message):
                self?.delegate?.didFailSignIn(message: message)
            case .success:
                self?.delegate?.didSignIn()
            }
        }
    }
}
