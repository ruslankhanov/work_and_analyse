//
//  LoginService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 03.03.2021.
//

import FirebaseAuth

class LoginService {
    
    enum LoginError: Error {
        case oneOrMoreValuesAreEmprty
        case cannotSignIn(Error)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<(), LoginError>) -> Void) {
        
        // Validate user data
        
        if let validationError = validateStrings(email: email, password: password) {
            
            return completion(.failure(validationError))
        }
        
        // Login user
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                return completion(.failure(.cannotSignIn(error!)))
            }
            
            return completion(.success(()))

        }
        
    }
    
    fileprivate func validateStrings(email: String, password: String) -> LoginError? {
        
        if email == "" || password == "" {
            return .oneOrMoreValuesAreEmprty
        }
        
        return nil
    }
    
}



