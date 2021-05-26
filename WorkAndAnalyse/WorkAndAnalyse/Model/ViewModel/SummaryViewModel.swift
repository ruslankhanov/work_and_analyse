//
//  SummaryViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 26.05.2021.
//

class SummaryViewModel: CellViewModel {
    var type: CellType = .outlineCell
    
    var title: String
    
    var rightDetailText: String
    
    init(title: String, rightDetailText: String) {
        self.title = title
        self.rightDetailText = rightDetailText
    }
}
