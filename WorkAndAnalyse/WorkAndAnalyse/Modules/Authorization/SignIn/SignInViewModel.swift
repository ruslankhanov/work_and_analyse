//
//  SignInViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 16.03.2021.
//

protocol SignInOutput {
    var finishSignIn: (() -> Void)? { get set }
    var failSignIn: ((String) -> Void)? { get set }
}

protocol SignInViewModelProtocol {
    var email: String { get set }
    var password: String { get set }
    
    func signInTap()
}

class SignInViewModel: SignInViewModelProtocol, SignInOutput {

    var signUpAction: (() -> Void)?
    var finishSignIn: (() -> Void)?
    var failSignIn: ((String) -> Void)?
    
    var email = ""
    var password = ""
    
    private let loginService: LoginService
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func signInTap() {
        loginService.signIn(email: email, password: password) { [weak self] response in
            switch response {
            case .failure(let message):
                self?.failSignIn?(message)
            case .success:
                self?.finishSignIn?()
            }
        }
    }
}
