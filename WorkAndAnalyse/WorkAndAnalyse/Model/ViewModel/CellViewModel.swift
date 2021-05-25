//
//  CellViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 22.05.2021.
//
import UIKit

protocol CellViewModel: class {
    var type: CellType { get set }
    
    var title: String { get }
    
    var subtitle: String { get }
    
    var rightDetailText: String { get }
    
    var isCompleted: Bool { get }
}

extension CellViewModel {
    var subtitle: String { "" }
}
