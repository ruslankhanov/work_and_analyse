//
//  TimeInterval+ToString.swift
//  WorkAndAnalyse
//
//  Created by Ruslan Khanov on 27.04.2021.
//

import Foundation

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        var result = String()
        
        let hours = (time / 3600)
        
        if hours != 0 {
            result += "\(hours)h"
        }
        
        let minutes = (time / 60) % 60
        
        if minutes != 0 {
            result += result.isEmpty ? "\(minutes)m" : " " + "\(minutes)m"
        }
        
        let seconds = time % 60
        
        if seconds != 0 {
            result += result.isEmpty ? "\(seconds)s" : " " + "\(seconds)s"
        }
    
        return result
    }
}
