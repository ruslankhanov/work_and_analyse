//
//  SignUpViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 11.03.2021.
//

protocol SignUpOutput {
    var finishSignUp: (() -> Void)? { get set }
    var failSignUp: ((String) -> Void)? { get set }
}

protocol SignUpViewModelProtocol {
    var email: String { get set }
    var username: String { get set }
    var password: String { get set }
    var passwordConfirmation: String { get set }
    
    func signUpTap()
}

class SignUpViewModel: SignUpViewModelProtocol, SignUpOutput {
    var finishSignUp: (() -> Void)?
    var failSignUp: ((String) -> Void)?
    
    var email = ""
    var username = ""
    var password = ""
    var passwordConfirmation = ""
    
    private let registrationService: RegistrationService
    
    init(registrationService: RegistrationService) {
        self.registrationService = registrationService
    }
        
    func signUpTap() {
        registrationService.signUp(email: email, username: username, password: password, passwordConfirmation: passwordConfirmation) { [weak self] response in
            switch response {
            case .failure(let message):
                self?.failSignUp?(message)
            case .success:
                self?.finishSignUp?()
            }
        }
    }
}
