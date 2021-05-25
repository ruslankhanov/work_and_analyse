//
//  TaskServiceImplementation.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import Foundation

enum TasksType {
    typealias FilterStatement = (Task) -> Bool
    
    case next
    case missing
    case history
    
    var filterStatement: FilterStatement {
        switch self {
        case .next:
            return { $0.endTime >= Date() && !$0.completed }
        case .missing:
            return { $0.endTime < Date() && !$0.completed }
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
    
    func loadTasks(type: TasksType, completion: @escaping (Result<[Task], Error>) -> Void) {
        repository.loadData(filter: type.filterStatement) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let tasks):
                completion(.success(tasks))
            }
        }
    }
    
    func createTask(title: String, startTime: Date, subtasks: [Subtask], completion: @escaping (Error?) -> Void) {
        let task = Task(title: title, startTime: startTime, subtasks: subtasks)
        
        repository.addTask(task) { error in
            if let error = error {
                completion(error)
                return
            }
        }
    }
    
    func updateTask(task: Task, completion: @escaping (Error?) -> Void) {
        repository.updateTask(task) { error in
            if let error = error {
                completion(error)
                return
            }
        }
    }
}
