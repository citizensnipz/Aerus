//
//  ChatView.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/25.
//

import Foundation
import SwiftUI


struct ChatView: View {
    
    var body: some View {
        ZStack {
            LinearGradient.primaryDarkGradient
                .edgesIgnoringSafeArea(.all)
            
            Image("aerus_a_logo_white")
                .resizable()
                .opacity(0.2)
                .frame(width: 251, height: 175)
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    //static var dateFormatter = AppDateFormatter()

    static var previews: some View {
        
        ChatView()
            //.environmentObject(dateFormatter)
    }
}
