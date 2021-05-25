//
//  Date+ToString.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 24.05.2021.
//

import Foundation

extension Date {
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        
        var result = ""
        
        if Calendar.current.isDateInToday(self) {
            result = "Today"
        } else if Calendar.current.isDateInTomorrow(self) {
            result = "Tomorrow"
        } else {
            result = formatter.string(from: self)
        }
        
        return result
    }
    
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: self)
    }
    
    func dateAndTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        return formatter.string(from: self)
    }
}
