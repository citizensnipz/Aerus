//
//  ContentView.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/4.
//

import SwiftUI
import Foundation




struct ListView: View {
    @EnvironmentObject var sheetManager: BottomSheetManager
    @State private var selectedTask: Task?
    @State var list: List
    
        
    var scheduler = Scheduler()
    var availableSlots: [DateInterval] = [DateInterval(start: Date().addingTimeInterval(-10 * 3600), end: Date().addingTimeInterval(10 * 3600))]
    
            
    var body: some View {
        ZStack {
            LinearGradient.primaryDarkGradient
                .edgesIgnoringSafeArea(.all)
            
            Image("aerus_a_logo_white")
                .resizable()
                .opacity(0.2)
                .frame(width: 251, height: 175)
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(list.tasks, id: \.id) { task in
                        if let index = list.tasks.firstIndex(where: { $0.id == task.id }) {
                            TaskCard(task: $list.tasks[index], onTap: {
                                selectedTask = list.tasks[index]
                                print("trying to toggle sheetmanager")
                                sheetManager.isShowing.toggle()
                            })
                            .cornerRadius(20)
                        }
                        
                    }
                    
                }
                
                
            }

            
            if sheetManager.isShowing {
                Shade()
                TaskViewBottomSheet(task: $selectedTask, list: list)
                    .cornerRadius(25)
                
            }
        }
        .animation(.easeInOut(duration: 0.5))
        
        
    }
}
        
    
func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter.string(from: date)
}


    

//struct ListView_Previews: PreviewProvider {
//    static var dateFormatter = AppDateFormatter()
//
////    var sampList = List(id: 0, name: "Personal", color: "#E59500", tasks: sampleTasks)
//
//    static var previews: some View {
//        var sampList = List(id: 0, name: "Personal", color: "#E59500", tasks: sampleTasks)
//
//        ListView(list: sampList, showOverlay: false)
//            .environmentObject(dateFormatter)
//    }
//}

