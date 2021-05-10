//
//  TaskServiceImplementation.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import Foundation
import FirebaseAuth

enum TasksType {
    typealias FilterStatement = (Task) -> Bool
    
    case next
    case missing
    case history
    
    var filterStatement: FilterStatement {
        switch self {
        case .next:
            return { $0.endTime <= Date() && !$0.completed }
        case .missing:
            return { $0.endTime > Date() && !$0.completed }
        case .history:
            return { $0.completed }
        }
    }
}

class TaskServiceImplementation: TaskService {
        
    private var repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func loadTasks(type: TasksType) -> [DateComponents: [Task]]? {
        let result = repository.tasks.filter(type.filterStatement)
        return result.isEmpty ? nil : groupByDay(tasks: result)
    }
    
    func createTask(title: String, startTime: Date, subtasks: [Subtask], completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let task = Task(id: nil, userId: userId, title: title, startTime: startTime, subtasks: subtasks)
        
        repository.addTask(task) { error in
            if let error = error {
                completion(error)
                return
            }
        }
    }
    
    // MARK: - Helpers
    private func groupByDay(tasks: [Task]) -> [DateComponents: [Task]] {
        let tasksGroupedByDay = Dictionary(grouping: tasks) { task in
            return Calendar.current.dateComponents([.day, .month, .year], from: task.startTime)
        }
        return tasksGroupedByDay
    }
}
