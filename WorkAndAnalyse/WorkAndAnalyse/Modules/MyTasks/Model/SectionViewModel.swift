//
//  SectionViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 22.05.2021.
//

class SectionViewModel {
    var title: String?
    var cells: [CellViewModel]
    
    init(title: String? = nil, cells: [CellViewModel] = []) {
        self.title = title
        self.cells = cells
    }
}
