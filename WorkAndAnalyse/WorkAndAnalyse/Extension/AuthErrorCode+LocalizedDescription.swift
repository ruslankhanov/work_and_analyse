//
//  AuthErrorCode+Ext.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 11.03.2021.
//

import Foundation
import FirebaseAuth

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .userNotFound:
            fallthrough
        case .wrongPassword:
            return "Wrong e-mail or password. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}
