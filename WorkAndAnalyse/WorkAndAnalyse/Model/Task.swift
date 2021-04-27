//
//  Task.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.03.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Task: Codable {
    @DocumentID var id: String?
    var userId: String
    var title: String
    var startTime: Date
    var subtasks: [Subtask]
    var completed: Bool {
        subtasks.allSatisfy { $0.completed }
    }
    
    var endTime: Date {
        let durations = subtasks.map { $0.duration }
        return Date(timeInterval: durations.reduce(TimeInterval.init(0), +), since: startTime)
    }
}

struct Subtask: Codable {
    var title: String
    var duration: TimeInterval
    var completed: Bool
}
