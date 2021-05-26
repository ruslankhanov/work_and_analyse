//
//  TaskService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//
import Foundation

protocol TaskService {
    func loadTasks(type: TasksType, completion: @escaping (Result<[Task], Error>) -> Void)
    func createTask(title: String, startTime: Date, subtasks: [Subtask], completion: @escaping (Error?) -> Void)
    func updateTask(task: Task, completion: @escaping (Error?) -> Void)
    func clearData(completion: ((Error?) -> Void)?)
}
