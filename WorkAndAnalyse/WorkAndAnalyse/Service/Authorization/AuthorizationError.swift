//
//  LoginError.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 11.03.2021.
//

import Foundation
import FirebaseAuth
import Firebase

enum AuthorizationError: Error {
    case oneOrMoreValuesAreEmprty
    case authError(Error)
    case passwordsDontMatch
    case invalidPassword
}

extension AuthorizationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .oneOrMoreValuesAreEmprty:
            return NSLocalizedString("Please fill in all fields.", comment: "")
        case .passwordsDontMatch:
            return NSLocalizedString("Passwords don't match.", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Please make sure your password is at least 8 characters, contains a special character and a number.", comment: "")
        case .authError(let error):
            return NSLocalizedString(errorCodeDescription(error: error), comment: "")
        }
    }
    
    private func errorCodeDescription(error: Error) -> String {
        guard let errorCode = AuthErrorCode(rawValue: error._code) else {
            return "Unknown error occurred"
        }
        
        return errorCode.errorMessage
    }
}
