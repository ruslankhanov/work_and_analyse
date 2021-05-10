//
//  SignInCoordinatorFinishOutput.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
