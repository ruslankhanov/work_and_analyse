//
//  RegistrationService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 02.03.2021.
//

import FirebaseAuth
import Firebase

class RegistrationService {
    
    enum RegistrationError: Error {
        case oneOrMoreValuesAreEmprty
        case passwordsDontMatch
        case invalidPassword
        
        case cannotCreateUser(Error)
        case cannotGetUID
        case cannotSaveUserData(Error)
    }
    
    func signUp(user: User, passwordConfirmation: String, completion: @escaping (Result<(), RegistrationError>) -> Void) {

        // Validate user data
        
        if let validationError = validateStrings(email: user.email, username: user.username, password: user.password, passwordConfirmation: passwordConfirmation) {
            
            return completion(.failure(validationError))
        }
        
        // Registrate with e-mail and password
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, err) in
            guard err == nil else {
                return completion(.failure(.cannotCreateUser(err!)))
            }
            
            guard let uid = result?.user.uid else {
                return completion(.failure(.cannotGetUID))
            }
            
            // Write user data to database
            
            let db = Firestore.firestore()
            
            db.collection("users").addDocument(data: [ "username": user.username, "uid": uid ]) { (error) in
                if let error = error {
                    return completion(.failure(.cannotSaveUserData(error)))
                }
            }
        }
        
        return completion(.success(()))
        
    }
    
    fileprivate func validateStrings(email: String, username: String, password: String, passwordConfirmation: String) -> RegistrationError? {
        
        if email == "" || username == "" || password == "" || passwordConfirmation == "" {
            return .oneOrMoreValuesAreEmprty
        }
        
        if !isPasswordValid(password) {
            return .invalidPassword
        }
        
        if password != passwordConfirmation {
            return .passwordsDontMatch
        }
                
        return nil
    }
    
    fileprivate func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
