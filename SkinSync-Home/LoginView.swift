//
//  LoginView.swift
//  Login
//
//  Created by student on 22/11/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Image("logo app")
                        .resizable()
                        .frame(width: 330, height: 120)
                        .padding(.top, -100)
                    
                    Text("Login to Your Account")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                        .padding(.top, -10)
                        .font(.system(size: 20))
                    
                    TextField("Username or email", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(22)
                        .font(.system(size: 15))
                        .padding(.horizontal, 30)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .frame(height: 35)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        } else {
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(22)
                    .padding(.horizontal, 30)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .frame(height: 35)
                    
                    Button(action: {
                        print("Login button tapped")
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                    }
                    .padding(.horizontal, 30)
                  
//                     Text("Or Login With")
//                         .foregroundColor(.black)
//                         .font(.system(size: 14))
//                         .padding(.top, 30)
                    
//                     Button(action: {
//                         print("Google login tapped")
//                     }) {
//                         ZStack {
//                             Circle()
//                                 .fill(Color.white)
//                                 .frame(width: 50, height: 50)
//                                 .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
//                             Image("logo google")
//                                 .resizable()
//                                 .scaledToFit()
//                                 .frame(width: 30, height: 30)
//                         }
//                     }.padding(.top, 20)
                  
                    HStack {
                        Text("Don’t have an account?")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                        //                        NavigationLink(destination: SignUpView()) {
                        //                            Text("Sign Up")
                        //                                .foregroundColor(.black)
                        //                                .font(.system(size: 16))
                        //                        }
                    }.padding(.top, 20)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
