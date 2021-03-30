//
//  LauchInstructor.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import Foundation
import FirebaseAuth

enum LaunchInstructor {
    
    case main
    case auth
    
    // MARK: - Public methods
    
    static func configure() -> LaunchInstructor {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.isAuthorized {
            return .main
        } else {
            return .auth
        }
    }
}
