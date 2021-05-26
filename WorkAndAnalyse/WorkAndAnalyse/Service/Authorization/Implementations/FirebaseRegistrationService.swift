//
//  RegistrationService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 02.03.2021.
//

import FirebaseAuth
import Firebase

class FirebaseRegistrationService: RegistrationService {
    
    static let shared = FirebaseRegistrationService()
    
    func signUp(email: String, username: String, password: String, passwordConfirmation: String, completion: @escaping ((AuthorizationResponse) -> Void)) {
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPasswordConfirmation = passwordConfirmation.trimmingCharacters(in: .whitespacesAndNewlines)

        // Validate user data
        
        if let validationError = validateStrings(
            email: cleanEmail,
            username: cleanUsername, password: cleanPassword, passwordConfirmation: cleanPasswordConfirmation) {
            
            completion(.failure(message: validationError.localizedDescription))
            return
        }
        
        // Registrate with e-mail and password
        
        Auth.auth().createUser(withEmail: cleanEmail, password: cleanPassword) { (result, err) in
            guard err == nil else {
                completion(.failure(message: AuthorizationError.authError(err!).localizedDescription))
                return
            }
            
            // TODO: Write user data to database
//
//            guard let uid = result?.user.uid else {
//                return completion(.failure(message: "Cannot get user's uid."))
//            }
//
//            let db = Firestore.firestore()
//
//            db.collection("users").document(uid).setData([
//                "id": uid,
//                "username": cleanUsername
//            ]) { error in
//                if error != nil {
//                    return completion(.failure(message: "Cannot save user data"))
//                }
//            }
            
            completion(.success)
        }
    }
    
    private func validateStrings(email: String, username: String, password: String, passwordConfirmation: String) -> AuthorizationError? {
        
        if email.isEmpty || username.isEmpty || password.isEmpty || passwordConfirmation == "" {
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
    
    private func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}


