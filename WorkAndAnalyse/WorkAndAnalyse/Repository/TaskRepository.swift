//
//  TaskRepository.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

protocol TaskRepository {
    func loadData(filter: ((Task) -> Bool)?, completion: @escaping (Result<[Task], Error>) -> Void)
    func addTask(_ task: Task, completion: @escaping (Error?) -> Void)
    func removeTask(_ task: Task, completion: @escaping (Error?) -> Void)
    func updateTask(_ task: Task, completion: @escaping (Error?) -> Void)
    
    func removeAllTasks(completion: ((Error?) -> Void)?)
}
