//
//  SubtaskViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

class SubtaskViewModel: CellViewModel {
    var subtask: Subtask
    weak var parent: TaskViewModel?
    
    var title: String {
        subtask.title
    }

    var rightDetailText: String {
        subtask.durationString
    }
    
    var isCompleted: Bool {
        subtask.completed
    }
    
    var type: CellType = .outlineCell
    
    init(subtask: Subtask, parent: TaskViewModel) {
        self.subtask = subtask
        self.parent = parent
    }
}
