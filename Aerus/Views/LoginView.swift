//
//  LoginView.swift
//  Aerus
//
//  Created by Joshua Kroslowitz on 2023/9/4.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                Image("ai_bg2")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 415, minHeight: 1 )
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.8) // Center the image
                    .edgesIgnoringSafeArea(.all)  // to ensure the image extends edge to edge
                
                // Content
                VStack(alignment: .center) {
                    Image("aerus_logo1")
                        .resizable()
                        .scaledToFit()   // Keeps the aspect ratio while fitting within the bounds
                        .frame(width: 320, height: 150)  // Adjust these values to your preference
                        .offset(y: -140)
                        .padding()
                    
                    Text("Schedule smart. Live better.")
                        .font(.custom("Avenir", size: 23))
                        .offset(y: -190)
                        .padding()
                    
                    TextField("Email", text: self.$email)
                        .textFieldStyle(CustomTextField())
                        .offset(y: -190)
                        .padding(.vertical, -5)

                    PasswordTextField(text: self.$password)
                        .offset(y: -200)
                        .padding(.vertical, -10)
                    
                    Button(action: {
                        // Handle login action
                        authViewModel.isAuthenticated = true

                    }) {
                        Text("login")
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 23))
                            .frame(width: 190, height: 12)
                            .padding()
                            .background(Color(red: 0, green: 0.15, blue: 0.26))
                            .cornerRadius(8)
                    }
                    .offset(y: -180)
                    .padding(.vertical, 0)
                    
                    Image("kiroshi_logo_white")
                        .resizable()
                        .frame(width: 135, height: 24)
                        .offset(y: 105)
                }
                .padding()
            }
        }
    }
}

struct CustomTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(11)
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color.white)
            ).padding()
    }
    
}

struct PasswordTextField: View {
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("Password", text: $text)
            } else {
                SecureField("Password", text: $text)
            }

            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                .foregroundColor(.gray)
                .onTapGesture {
                    isPasswordVisible.toggle()
                }
        }
        .padding(11)
        .frame(width: 300)
        .background(
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color.white)
        )
        .padding()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
