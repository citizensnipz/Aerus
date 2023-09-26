//
//  CustomTabView.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/25.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var sheetManager: BottomSheetManager

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Content Views
                ZStack {
                    if selectedTab == 0 {
                        ChatView()
                    } else if selectedTab == 1 {
                        AllListView()
                            .environmentObject(BottomSheetManager())
                    } else if selectedTab == 2 {
                        Text("Calendar Content")
                    } else if selectedTab == 3 {
                        Text("Task Content")
                    }
                    
                }
                .frame(maxHeight: .infinity)
                // padding pushes content down below the top nav
                .padding(.top, 50)
                
                
                // Custom Tab Bar
                HStack(spacing: 54) {
                    VStack {
                        TabButton(image: "bubble.left.and.bubble.right.fill", isSelected: $selectedTab, index: 0)
                        TabText(text: "Chat", isSelected: $selectedTab, index: 0)
                    }
                    VStack {
                        TabButton(image: "list.bullet", isSelected: $selectedTab, index: 1)
                        TabText(text: "Lists", isSelected: $selectedTab, index: 1)
                    }
                    VStack {
                        TabButton(image: "calendar", isSelected: $selectedTab, index: 2)
                        TabText(text: "Calendar", isSelected: $selectedTab, index: 2)
                    }
                    VStack {
                        TabButton(image: "calendar.day.timeline.left", isSelected: $selectedTab, index: 3)
                        TabText(text: "Tasks", isSelected: $selectedTab, index: 3)
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding()
                .background(Color(hex: "#002642"))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
            // Top nav
            VStack {
                HStack {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color(hex: "#E5DADA"))
                        .font(.system(size: 24))
                        .padding()
                    Spacer()
                }
                .foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width, height: 50)
                .background(Color(hex: "#002642")) // Color can be changed as per your requirement
                Spacer()  // This pushes the HStack to the top
            }
        }
    }
    
}

struct TabButton: View {
    let image: String
    @Binding var isSelected: Int
    let index: Int
    
    var body: some View {
        Button(action: {
            isSelected = index
        }) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected == index ? Color(hex: "#E5DADA") : Color(.gray).opacity(0.65))
                .padding(.bottom, 0)
        }
    }
}

struct TabText: View {
    let text: String
    @Binding var isSelected: Int
    @StateObject var colorModeSetting = ColorModeSetting()
    let index: Int
    
    var body: some View {
        Text(text)
            .fancySmallTextStyle(colorMode: colorModeSetting.currentMode)
            .opacity(isSelected == index ? 1 : 0.65)
    }
}

struct MainView_Previews: PreviewProvider {
    static var dateFormatter = AppDateFormatter()
    
    static var previews: some View {
        MainView()
            .environmentObject(dateFormatter)
    }
}

