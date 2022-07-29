//
//  Hours.swift
//  YelpSearch
//
//  Created by Lucio on 30/07/2022.
//

import Foundation

enum DayOfWeek: Int {
    case monday = 0
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case anyday
    
    var dayOfWeek: String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .anyday:
            return "Anyday"
        }
    }
}

struct OpenHour: Codable {
    var day: Int = 0
    var start: String?
    var end: String?
    
    var dayOfWeek: DayOfWeek {
        return DayOfWeek(rawValue: day) ?? .anyday
    }
    
    var startTime: String {
        guard let startTime = start?.toDateFormat() else {
            return "00:00"
        }
        
        return startTime
    }
    
    var endTime: String {
        guard let endTime = end?.toDateFormat() else {
            return "00:00"
        }
        
        return endTime
    }
    
    var description: String {
        return "\(dayOfWeek.dayOfWeek), \(startTime) - \(endTime)"
    }
}
