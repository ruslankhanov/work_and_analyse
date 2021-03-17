//
//  LoginService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 03.03.2021.
//

import FirebaseAuth

class LoginService {
        
    func signIn(email: String, password: String, completion: @escaping (AuthorizationResponse) -> Void) {
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validate user data
        
        if let validationError = validateStrings(email: cleanEmail, password: cleanPassword) {
            
            return completion(.failure(message: validationError.localizedDescription))
        }
        
        // Login user
        
        Auth.auth().signIn(withEmail: cleanEmail, password: cleanPassword) { (result, error) in
            guard error == nil else {
                return completion(.failure(message: AuthorizationError.authError(error!).localizedDescription))
            }
            return completion(.success)
        }        
    }
    
    fileprivate func validateStrings(email: String, password: String) -> AuthorizationError? {
        
        if email == "" || password == "" {
            return .oneOrMoreValuesAreEmprty
        }
        
        return nil
    }
    
}



