//
//  LoginService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 30.03.2021.
//

protocol LoginService {
    func signIn(email: String, password: String, completion: @escaping (AuthorizationResponse) -> Void)
    func signOut(completion: @escaping (Error?) -> Void)
}
