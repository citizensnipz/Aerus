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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    
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
                                sheetManager.isShowing.toggle()
                            })
                            .cornerRadius(20)
                        }
                        
                    }
                    
                }
                .padding(.top, 20)
                
            }
            
            
            if sheetManager.isShowing {
                Shade()
                TaskViewBottomSheet(task: $selectedTask, list: list)
                    .cornerRadius(25)
                
            }
        }
        .animation(.easeInOut(duration: 0.5))
        .navigationBarBackButtonHidden(true)// This hides the default back button
        .navigationTitle(list.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
//            ToolbarItem(placement: .navigation) {
//                Text(list.name)
//                    .titleLargeStyle()
//                    .foregroundColor(Color(hex: "#E5DADA"))
//                    .padding(24)
//            }
        }

        
        
    }
    
    var backButton: some View {
        
        
            Button(action: {
                sheetManager.isShowing = false
                dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#E5DADA"))
                        .font(.system(size: 24))
                        
                }
            }
            .padding(.leading, 12)
        }
}
        
    
func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter.string(from: date)
}


