//
//  SignUpViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 11.03.2021.
//

protocol SignUpDelegate: AnyObject {
    func didSignUp()
    func didFailSignUp(message: String)
}

class SignUpViewModel {
    
    private let registrationService: RegistrationService
    weak var delegate: SignUpDelegate?
    
    var email = ""
    var username = ""
    var password = ""
    var passwordConfirmation = ""
    
    init(registrationService: RegistrationService) {
        self.registrationService = registrationService
    }
        
    func signUpTap() {
        registrationService.signUp(email: email, username: username, password: password, passwordConfirmation: passwordConfirmation) { [weak self] response in
            switch response {
            case .failure(let message):
                self?.delegate?.didFailSignUp(message: message)
            case .success:
                self?.delegate?.didSignUp()
            }
        }
    }
}
