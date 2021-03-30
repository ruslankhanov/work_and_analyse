//
//  MainTabBarOutput.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 29.03.2021.
//

import UIKit

protocol MainTabBarViewOutput {
    var onTaskCreationFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
