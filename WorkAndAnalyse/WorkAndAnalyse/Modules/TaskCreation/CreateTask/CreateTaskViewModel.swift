//
//  CreateTaskViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.03.2021.
//

import Foundation

protocol CreateTaskViewModelProtocol {
    var title: String { get set }
    
    func create()
}

class CreateTaskViewModel: CreateTaskViewModelProtocol {
    var title = ""
    
    func create() {
        #warning("Non-implemented")
    }
}
