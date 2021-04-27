//
//  TaskServiceImplementation.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import Foundation
import FirebaseAuth

class TaskServiceImplementation: TaskService {
    
    var tasks: [Task] = []
    
    private var repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
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
    
    func loadTasks(completion: @escaping (Error?) -> Void) {
        repository.loadData { [weak self] result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let tasks):
                self?.tasks = tasks
            }
        }
    }
}
