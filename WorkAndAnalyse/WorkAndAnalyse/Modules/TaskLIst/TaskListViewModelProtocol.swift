//
//  TaskListViewModelProtocol.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.05.2021.
//

import Foundation

protocol TaskListViewModelProtocol {
    var dataToPresent: [SectionViewModel] { get set }
    func loadDataToPresent()
    func updateTask(with model: CellViewModel, at indexPath: IndexPath)
}

protocol TaskListViewModelDelegate: class {
    func didFailToLoadData(errorMessage: String)
    func didLoadData()
    func didUpdateData(at indexPaths: [IndexPath])
}
