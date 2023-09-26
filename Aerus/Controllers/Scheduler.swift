//
//  Scheduler.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//

import Foundation

class Scheduler {
    
    // ... (Keep the Task and Priority from before here or in their respective files) ...

    // Process the initial slots by removing work and sleep periods
    func getAvailableSlotsExcludingWorkSleep(slots: [DateInterval], workPeriods: [WorkPeriod], sleepPeriods: [SleepPeriod]) -> [DateInterval] {
        var modifiedSlots = slots

        // Process WorkPeriods
        for work in workPeriods {
            let workInterval = DateInterval(start: work.start, end: work.end)
            modifiedSlots = modifiedSlots.flatMap { slot -> [DateInterval] in
                if slot.intersects(workInterval) && work.days.contains(currentDayOfWeek(date: slot.start)) {
                    var newSlots: [DateInterval] = []
                    if slot.start < workInterval.start {
                        newSlots.append(DateInterval(start: slot.start, end: workInterval.start))
                    }
                    if slot.end > workInterval.end {
                        newSlots.append(DateInterval(start: workInterval.end, end: slot.end))
                    }
                    return newSlots
                }
                return [slot]
            }
        }

        // Process SleepPeriods
        for sleep in sleepPeriods {
            let sleepInterval = DateInterval(start: sleep.start, end: sleep.end)
            modifiedSlots = modifiedSlots.flatMap { slot -> [DateInterval] in
                if slot.intersects(sleepInterval) && sleep.days.contains(currentDayOfWeek(date: slot.start)) {
                    var newSlots: [DateInterval] = []
                    if slot.start < sleepInterval.start {
                        newSlots.append(DateInterval(start: slot.start, end: sleepInterval.start))
                    }
                    if slot.end > sleepInterval.end {
                        newSlots.append(DateInterval(start: sleepInterval.end, end: slot.end))
                    }
                    return newSlots
                }
                return [slot]
            }
        }


        return modifiedSlots
    }
    
    func currentDayOfWeek(date: Date) -> DayOfWeek {
        let weekday = Calendar.current.component(.weekday, from: date)
        return DayOfWeek.allCases[weekday - 1] // Note: weekday is 1-based
    }
    
    func scheduleTasks(tasks: [Task], availableSlots: [DateInterval], workPeriods: [WorkPeriod], sleepPeriods: [SleepPeriod]) -> [Task] {
        var scheduledTasks = [Task]()
        var mutableTasks = tasks
        
        var trueSlots = getAvailableSlotsExcludingWorkSleep(slots: availableSlots, workPeriods: workPeriods, sleepPeriods: sleepPeriods)

        // Sort tasks by priority
        mutableTasks.sort { $0.priority.rawValue > $1.priority.rawValue }
        
        for task in mutableTasks {
            for (index, slot) in trueSlots.enumerated() {
                if task.duration <= Int(slot.duration / 60) {
                    var scheduledTask = task
                    scheduledTask.scheduledTime = slot.start
                    scheduledTasks.append(scheduledTask)

                    // Update the slot by subtracting task duration
                    let newStart = slot.start.addingTimeInterval(TimeInterval(task.duration * 60))
                    trueSlots[index] = DateInterval(start: newStart, end: slot.end)
                    break
                }
            }
        }
        return scheduledTasks
    }
    
    func rescheduleTask(task: Task, to newTime: Date) {
        // Update task's status in your data storage
        // ...
    }
}

