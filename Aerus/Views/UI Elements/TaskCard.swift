//
//  TaskCard.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/22.
//
import SwiftUI

var scheduler = Scheduler()

struct TaskCard: View {
    @Binding var task: Task
    var onTap: () -> Void //callback func
    //@Binding var showOverlay: Bool
    @State private var showingDatePicker: Bool = false
    @State private var newTaskTime: Date = Date()
    @State private var dragOffset: CGSize = .zero
    @ObservedObject var taskStore = TaskStore()
    @EnvironmentObject var dateFormatter: AppDateFormatter
    
    
    var body: some View {

        
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(hex: "#E5DADA"))
                .frame(width: 353, height: 134)
                .padding(0)
                .opacity(task.wasCompleted ? 0.5 : 1)

                
            HStack {
                Button(action: {
                    task.wasCompleted.toggle()
                    markTaskAsComplete(task: task)
                }) {
                    Image(systemName: task.wasCompleted ? "checkmark.square" : "square")
                }
                .buttonStyle(CheckboxStyle())

                VStack(alignment: .leading, spacing: 8) {
                    Text(task.name).titleMediumStyle()
                        .frame(width: 240, alignment: .leading)
                    if let scheduledTime = task.scheduledTime {
                        Text(dateFormatter.formatter.string(from: scheduledTime))
                            .bodyLargeTextStyle()
                            .opacity(0.65)
                            .frame(width: 240, alignment: .leading)
                        }
                    if let taskDescription = task.description {
                        Text(taskDescription)
                            .bodySmallTextStyle()
                            .opacity(0.65)
                            .frame(width: 240, alignment: .leading)
                    }
                }
                .padding(.leading, 16)
                
                Spacer()
                    .frame(width: 32)
                
                DragHandle()

            }
            .padding(.leading, 16)
            
        }
        .onTapGesture {
            onTap()
        }
        
        
        
        
    }
    
    struct DragHandle: View {
        var body: some View {
            VStack(spacing: 4) {
                ForEach(0..<3) { _ in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 5, height: 5)
                }
            }
        }
    }
    
    struct CheckboxStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.black, lineWidth: 2)
                        .background(configuration.isPressed ? Color.gray : Color.white)
                        .frame(width: 24, height: 24)
                )
                .background(configuration.isPressed ? Color.gray : Color.white)
        }
    }

    func markTaskAsComplete(task: Task) {
        if let index = taskStore.tasks.firstIndex(where: { $0.id == task.id }) {
                taskStore.tasks[index].wasCompleted = true
            } else {
                print("Task not found!")
            }
    }
    
    func markTimeAsUnsuitable(task: Task) {
        // Update task's status in your data storage
        // ...
    }
    
    // ... other functions like `rescheduleTask` and `markTimeAsUnsuitable` go here
}


