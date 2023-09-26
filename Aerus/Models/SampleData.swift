//
//  SampleData.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//

import Foundation

//This is essentially a DB for the tasks. It stores the static information for reference.
//It is unordered but it IS mutable

var sampleTasks: [Task] = [
    Task(id: 1,
         name: "Exercise",
         duration: 60,
         priority: .medium,
         dependencies: [],
         scheduledTime: nil, //Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 10, hour: 14, minute: 30))!,
         alarm: true,
         alarmOffset: 10,
         description: "Arms and chest"),
         
    Task(id: 2,
         name: "Study for Math Exam",
         duration: 180,
         priority: .high,
         dependencies: [],
         scheduledTime: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 10, hour: 17, minute: 60))!,
         alarm: true,
         alarmOffset: 30,
         description: "p. 167 - 174, differential equations. Call Jerome, see if he wants to study together"),
         
    Task(id: 3,
         name: "Grocery Shopping",
         duration: 40,
         priority: .low,
         dependencies: [],
         scheduledTime: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 10, hour: 10, minute: 60))!,
         alarm: false,
         alarmOffset: 0,
        description: "Milk, eggs, bread"),
         
    Task(id: 4,
         name: "Complete Coding Assignment",
         duration: 120,
         priority: .high,
         dependencies: [2],
         scheduledTime: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 10, hour: 19, minute: 90))!,
         alarm: true,
         alarmOffset: 20,
        description: "Create UI elements in Swift, backend portion in Python")
         
    // ... add more tasks as needed
]

//This is essentially the model for the tasks
//It initializes the tasks by sorting them and allows to append more to the list

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = sampleTasks
    
    var scheduler = Scheduler()

        init() {
            self.tasks = []
            setupTasks()
        }

    private func setupTasks() {
      //this is a placeholder for when we have useful user data for user preferences as far as scheduling is concerned
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let wholeDaySlot = DateInterval(start: startOfDay, end: endOfDay)

        // Filter tasks that already have a scheduled time
        let unscheduledTasks = sampleTasks.filter { $0.scheduledTime == nil }

        // Presuming you have available slots, work periods, and sleep periods data
        let availableSlots: [DateInterval] = [wholeDaySlot] // Provide available slots here
        let workPeriods: [WorkPeriod] = workPeriods// Provide work periods here
        let sleepPeriods: [SleepPeriod] = sleepPeriods// Provide sleep periods here

        let scheduledTasks = scheduler.scheduleTasks(tasks: unscheduledTasks,
                                                     availableSlots: availableSlots,
                                                     workPeriods: workPeriods,
                                                     sleepPeriods: sleepPeriods)

        // Combine tasks that were already scheduled with the new scheduled tasks
        self.tasks = sampleTasks.filter { $0.scheduledTime != nil } + scheduledTasks

        //sorts the tasks by scheduled time
        self.tasks = tasks.sorted(by: { ($0.scheduledTime ?? Date.distantPast) < ($1.scheduledTime ?? Date.distantPast)})

        }

        func addTask(_ task: Task) {
            tasks.append(task)

            // Re-schedule tasks if necessary every time a task is added
            setupTasks()
        }
}

