//
//  Task.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.03.2021.
//

import Foundation

struct Task: Codable {
    var title: String
    var startTime: Date
    var subtasks: [Subtask]
    
    var endTime: Date {
        get {
            let durations = subtasks.map { $0.duration }
            return Date(timeInterval: durations.reduce(TimeInterval.init(0), +), since: startTime)
        }
    }
}

struct Subtask: Codable {
    var title: String
    var duration: TimeInterval
}
