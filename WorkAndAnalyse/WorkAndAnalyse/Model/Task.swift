//
//  Task.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 25.03.2021.
//

import Foundation
import FirebaseFirestoreSwift

class Task: Codable {
    @DocumentID var id: String?
    var title: String
    var startTime: Date
    var subtasks: [Subtask]
    var completed: Bool {
        subtasks.allSatisfy { $0.completed }
    }
    
    private var duration: TimeInterval {
        subtasks.map { $0.duration }.reduce(TimeInterval(0), +)
    }
    
    var durationString: String {
        duration.stringFromTimeInterval()
    }
    
    var endTime: Date {
        Date(timeInterval: duration, since: startTime)
    }
    
    init(title: String, startTime: Date, subtasks: [Subtask]) {
        self.title = title
        self.startTime = startTime
        self.subtasks = subtasks
    }
}

class Subtask: Codable {
    var title: String
    var duration: TimeInterval
    var completed: Bool
    
    weak var parent: Task?
    
    var durationString: String {
        duration.stringFromTimeInterval()
    }
    
    init(title: String, duration: TimeInterval, completed: Bool) {
        self.title = title
        self.duration = duration
        self.completed = completed
    }
}
