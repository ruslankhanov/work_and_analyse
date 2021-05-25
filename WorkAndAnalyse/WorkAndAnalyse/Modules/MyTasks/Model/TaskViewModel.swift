//
//  TaskViewModel.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 28.04.2021.
//
import UIKit

class TaskViewModel: CellViewModel {    
    let task: Task
    
    var title: String {
        task.title
    }
    
    var subtitle: String {
        task.startTime.dateAndTimeString()
    }
    
    var rightDetailText: String {
        task.durationString
    }
    
    var isCompleted: Bool {
        task.completed
    }
    
    var children: [SubtaskViewModel]
    var isCollapsed: Bool
    
    var type: CellType = .detailTextViewCell
    
    init(task: Task, children: [SubtaskViewModel] = [], isCollapsed: Bool = true) {
        self.task = task
        self.children = children
        self.isCollapsed = isCollapsed
    }
}
