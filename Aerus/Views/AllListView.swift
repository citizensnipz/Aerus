//
//  AllListView.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/26.
//

import Foundation
import SwiftUI


struct AllListView: View {
    @ObservedObject var allLists = AllLists()
    @ObservedObject var taskStore = TaskStore()
    //@Binding var showOverlay: Bool
    
    
    // Define the layout for two columns
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {

            NavigationView {
                ZStack {
                    LinearGradient.primaryDarkGradient
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("aerus_a_logo_white")
                        .resizable()
                        .opacity(0.2)
                        .frame(width: 251, height: 175)
                        .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(allLists.lists) { list in
                            NavigationLink(destination: ListView(list: list)) {
                                ListSquare(name: list.name, color: Color(hex: list.color))
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.clear)
                .navigationBarHidden(true)
            }
            .background(Color.clear)
            
            
        }
        
    }
}


struct ListSquare: View {
    var name: String
    var color: Color
    
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .frame(width: 120, height: 120)
                    
                    Text(name)
                        .titleMediumStyle()
                        .foregroundColor(.black)
                }
    }
}
