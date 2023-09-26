//
//  TaskViewOverlay.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/23.
//
import SwiftUI
import Foundation

struct TaskViewBottomSheet: View {
    @EnvironmentObject var sheetManager: BottomSheetManager
    // Initial position of the sheet
    // SMALLER multiplier means it starts HIGHER in the screen
    // because the initial edge is the "bottom" which is right above
    // the nav bar
    @State private var sheetPosition: CGFloat =  UIScreen.main.bounds.height * 0.35
    @Binding var task: Task?
    @ObservedObject var taskStore = TaskStore()
    @State var list: List
    
    //replace this with the reminder value in the Task
    @State private var isOn = false

    var body: some View {
        ZStack {
                VStack {
                    Rectangle()
                        .fill(Color(hex: "#969696"))
                        .cornerRadius(50)
                        .frame(width: 160, height: 8)
                        .padding(.vertical, 8)
                        .gesture(DragGesture().onChanged { value in
                            // Your drag offset logic
                        }.onEnded { value in
                            // Logic to handle end of drag
                            if value.translation.height > 200 {
                                sheetManager.isShowing.toggle()
                            }
                        })
                    
                    //Checkbox, title and delete trash can
                    HStack {
                        Button(action: {
                            task?.wasCompleted.toggle()
                            if let unwrappedTask = task {
                                markTaskAsComplete(task: unwrappedTask)
                            }
                            
                        }) {
                            Image(systemName: task?.wasCompleted == true ? "checkmark.square" : "square")
                            
                        }
                        .buttonStyle(CheckboxStyle())
                        .padding(.leading, 24)
                        
                        Text(task?.name ?? "Task name")
                            .font(.custom("Avenir", size: 24))
                            .fontWeight(.bold)
                            .padding(.leading, 24)
                        
                        Spacer()
                        // Other UI elements for editing task
                        Button(action: {
                            // Code to delete task
                            sheetManager.isShowing = false
                        }) {
                            Image(systemName: "trash.fill")
                        }
                        .foregroundColor(.red)
                        .padding(.trailing, 24)
                        
                        
                    }
                    .padding(.bottom, 30)
                    
                    VStack {
                        Text(task?.description ?? "")
                            .fancyBodyTextStyle(colorMode: .light)
                            .padding(.leading, 24)
                            .padding(.trailing, 24)
                        
                        DropDownMenuView(list: list)
                        
                        
                        HStack {
                            Spacer()
                            Image("reminder-30")
                            Text("Reminder")
                            Spacer()
                            Toggle(isOn: $isOn) {
                                
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "alarm.fill")
                            Text("Alarm")
                        }
                        HStack {
                            Text("Notification")
                        }
                        HStack {
                            Text("Repeat")
                        }
                        HStack {
                            Text("Location")
                        }
                    }
                    
                    Spacer()
                }
                

        }
        .frame(width: UIScreen.main.bounds.width)
        .transition(.move(edge: .bottom))
        .background(Color(hex: "#E5DADA"))
        .cornerRadius(20)
        .offset(y: sheetPosition)
        .gesture(
            DragGesture()
                .onChanged { value in
                    // This moves the sheet based on drag
                    // Forces sheet to take up entire screen when dragged up
                    withAnimation {
                        sheetPosition = min(UIScreen.main.bounds.height, max(0, sheetPosition + value.translation.height))
                    }
                }
                .onEnded { value in
                    let midPosition = UIScreen.main.bounds.height * 0.35
                    let closeThreshold: CGFloat = 180
                    let openThreshold: CGFloat = -50
                    
                    // Closer to the full
                    if sheetPosition < midPosition {
                        withAnimation {
                            sheetPosition = 0
                        }
                    } else { // Closer to the middle position
                        if value.translation.height < openThreshold {
                            // Dragged upward beyond the threshold
                            withAnimation {
                                sheetPosition = 0
                            }
                            // if user drags down hard enough
                        } else if value.translation.height >  closeThreshold {
                            withAnimation {
                                sheetManager.isShowing = false
                            }
                        } else {
                            // Snap to the middle position
                            withAnimation {
                                sheetPosition = midPosition
                            }
                        }
                    }
                }
        )
    }
    
    func markTaskAsComplete(task: Task) {
        if let index = taskStore.tasks.firstIndex(where: { $0.id == task.id }) {
                taskStore.tasks[index].wasCompleted = true
            } else {
                print("Task not found!")
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
    
    struct DropDownMenuView: View {
        @State private var showDropdown = false
        @ObservedObject var allLists = AllLists()
        @State var list: List
        
        var body: some View {
            VStack {
                Button(action: {
                    showDropdown.toggle()
                }) {
                    HStack{
                        Text(list.name)
                            .font(.custom("Avenir", size: 20))
                            .foregroundColor(.black)
                            .padding(.leading, 14)
                        Spacer()
                        Image("chevron_up_chevron_down")
                            .foregroundColor(.black)
                            .padding(.trailing, 14)
                            .opacity(0.65)
                    }
                    .frame(width: 335, height: 33)
                    .background(Color(hex: list.color))
                    .cornerRadius(8)
                }
                .popover(
                    isPresented: $showDropdown,
                    arrowEdge: .bottom
                )
                {
                    VStack {
                        ForEach(allLists.names, id: \.self) { option in
                            Button(action: {
                                print("\(option) selected")
                                showDropdown = false
                            }) {
                                Text(option)
                                    .padding()
                            }
                        }
                        
                    }
                }
                
            }
            .padding()
        }
    }
    

    
}


