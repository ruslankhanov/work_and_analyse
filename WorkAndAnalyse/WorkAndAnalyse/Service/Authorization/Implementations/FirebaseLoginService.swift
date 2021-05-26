//
//  LoginService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 03.03.2021.
//

import FirebaseAuth

class FirebaseLoginService: LoginService {
    
    static let shared = FirebaseLoginService()

    func signIn(email: String, password: String, completion: @escaping (AuthorizationResponse) -> Void) {
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validate user data
        
        if let validationError = validateStrings(email: cleanEmail, password: cleanPassword) {
            completion(.failure(message: validationError.localizedDescription))
            return
        }
        
        // Login user
        
        Auth.auth().signIn(withEmail: cleanEmail, password: cleanPassword) { (result, error) in
            guard error == nil else {
                completion(.failure(message: AuthorizationError.authError(error!).localizedDescription))
                return
            }
            completion(.success)
            return
        }        
    }
    
    func signOut(completion: @escaping (Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(nil)
        } catch let signOutError as NSError {
            completion(signOutError)
            print ("Error signing out: %@", signOutError)
        }
    }
    
    private func validateStrings(email: String, password: String) -> AuthorizationError? {
        
        if email == "" || password == "" {
            return .oneOrMoreValuesAreEmprty
        }
        
        return nil
    }
    
}



