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
    
    private var duration: TimeInterval {
        subtasks.map { $0.duration }.reduce(TimeInterval(0), +)
    }
    
    var durationString: String {
        duration.stringFromTimeInterval()
    }
    
    var endTime: Date {
        Date(timeInterval: duration, since: startTime)
    }
}

struct Subtask: Codable {
    var title: String
    var duration: TimeInterval
    var completed: Bool
    
    var durationString: String {
        duration.stringFromTimeInterval()
    }
}
