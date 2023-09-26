//
//  AerusApp.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/4.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
}

class BottomSheetManager: ObservableObject {
    @Published var isShowing: Bool = false
}

@main
struct AerusApp: App {
    @StateObject var dateFormatter = AppDateFormatter()
    @StateObject var authViewModel = AuthViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainView()
                    .environmentObject(authViewModel)
                    .environmentObject(dateFormatter)
                    .environmentObject(BottomSheetManager())
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

