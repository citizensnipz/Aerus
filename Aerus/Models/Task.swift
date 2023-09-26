//
//  Task.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//

import Foundation

struct Task: Identifiable {
    let id: Int
    let name: String
    var duration: Int  // in minutes
    var priority: Priority
    var dependencies: [Int]
    var scheduledTime: Date?
    var alarm: Bool
    var alarmOffset: Int  // in minutes, how much time before the scheduledTime the alarm should ring
    var wasCompleted: Bool = false
    var rescheduleCount: Int = 0
    var initialScheduleTime: Date?
    var lastRescheduledTime: Date?
    var description: String?
}

enum Priority: Int {
    case high = 3
    case medium = 2
    case low = 1
}
