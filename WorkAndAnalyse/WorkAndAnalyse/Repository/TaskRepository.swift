//
//  TaskRepository.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

protocol TaskRepository {
    func loadData(completion: @escaping (Result<[Task], Error>) -> Void)
    func addTask(_ task: Task, completion: @escaping (Error?) -> Void)
    func removeTask(_ task: Task, completion: @escaping (Error?) -> Void)
}
