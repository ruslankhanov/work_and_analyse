//
//  RegistrationService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 30.03.2021.
//

protocol RegistrationService {
    func signUp(email: String, username: String, password: String, passwordConfirmation: String, completion: @escaping ((AuthorizationResponse) -> Void))
}
