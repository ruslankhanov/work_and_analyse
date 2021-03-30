//
//  TaskCreationCoordinatorFinishOutput.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.03.2021.
//

import Foundation
protocol TaskCreationCoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
