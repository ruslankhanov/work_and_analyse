//
//  TaskService.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//
import Foundation

protocol TaskService {
    func loadTasks(type: TasksType) -> [DateComponents: [Task]]?
    func createTask(title: String, startTime: Date, subtasks: [Subtask], completion: @escaping (Error?) -> Void)
    //func removeTask()
}
