//
//  MyTasksViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//

import Foundation

struct SectionViewModel {
    let title: String
    let cells: [CollapsableViewModel]
}

protocol MyTasksViewModelProtocol {
    var dataToPresent: [SectionViewModel] { get set }
}

protocol MyTasksViewModelDelegate {
    func didFailToLoadData(errorMessage: String)
    func didLoadData()
}

class MyTasksViewModel: MyTasksViewModelProtocol {
    
    // MARK: - Vars & Lets
    var dataToPresent: [SectionViewModel] = []
    
    var delegate: MyTasksViewModelDelegate?
    
    private let taskService: TaskService
    
    // MARK: - Init
    
    init(taskService: TaskService) {
        self.taskService = taskService
        loadDataToPresent()
    }
    
    // MARK: - Private methods
    
    private func loadDataToPresent() {

    }
}
