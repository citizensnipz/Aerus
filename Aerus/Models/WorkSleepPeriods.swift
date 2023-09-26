//
//  WorkSleepPeriods.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//

import Foundation

enum DayOfWeek: String, CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

struct WorkPeriod {
    var start: Date
    var end: Date
    var days: [DayOfWeek]
}

struct SleepPeriod {
    var start: Date
    var end: Date
    var days: [DayOfWeek]
}

let calendar = Calendar.current

// Helper function to get a Date for a specific hour today
func dateForHour(_ hour: Int) -> Date {
    var components = calendar.dateComponents(in: TimeZone.current, from: Date())
    components.hour = hour
    components.minute = 0
    components.second = 0
    return calendar.date(from: components)!
}

var workPeriods: [WorkPeriod] {
    let workStart = dateForHour(9)  // 9am
    let workEnd = dateForHour(17)  // 5pm
    return [
        WorkPeriod(start: workStart, end: workEnd, days: [.monday, .tuesday, .wednesday, .thursday, .friday])
    ]
}


let sleepPeriods: [SleepPeriod] = [
    SleepPeriod(
        start: Calendar.current.startOfDay(for: Date()),
        end: Calendar.current.startOfDay(for: Date()).addingTimeInterval(8 * 3600),
        days: [.monday, .tuesday, .wednesday, .thursday, .sunday]  // Specify multiple days here
    ),
    SleepPeriod(
        start: Calendar.current.startOfDay(for: Date()).addingTimeInterval(1 * 3600),  // 1AM of today
        end: Calendar.current.startOfDay(for: Date()).addingTimeInterval(9 * 3600),    // 9AM of today
        days: [.friday, .saturday]  // For Friday and Saturday
    )

    // ... add more SleepPeriods as needed
]

