//
//  VerificationView.swift
//  Login
//
//  Created by student on 22/11/24.
//

import SwiftUI

struct VerificationView: View {
    @State private var username: String = ""
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var year: String = ""
    @State private var month: String = ""
    @State private var day: String = ""
    @State private var selectedGender: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Text("Create Profile")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 40)
                        .font(.system(size: 20))
                        
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 133, height: 133)
                        .padding(.bottom, -118)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .padding(.top, -40)
                        .foregroundColor(Color.gray.opacity(0.6))
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Edit Profile")
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title)
                                    .foregroundColor(Color.gray)
                                    .padding(5)
                                    .clipShape(Circle())
                            }
                            .padding(.top, -240)
                            .padding(.trailing, 110)
                        }
                    }
                    
                    Group {
                        Text("Username")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .padding(.top, -100)
                            .font(.system(size: 15))
                        
                        TextField("Username", text: $username)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                                  .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(22)
                            .font(.system(size: 15))
                            .padding(.leading, 35)
                            .padding(.trailing, 35)
                            .frame(height: 35)
                            .padding(.top, -103)
                        
                        Text("First Name")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .font(.system(size: 15))
                            .padding(.top, -85)
                        
                        TextField("First Name", text: $firstname)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(22)
                            .font(.system(size: 15))
                            .padding(.leading, 35)
                            .padding(.trailing, 35)
                            .frame(height: 35)
                            .padding(.top, -88)
                        
                        Text("Last Name")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .font(.system(size: 15))
                            .padding(.top, -70)
                        
                        TextField("Last Name", text: $lastname)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(22)
                            .font(.system(size: 15))
                            .padding(.leading, 35)
                            .padding(.trailing, 35)
                            .frame(height: 35)
                            .padding(.top, -73)
                        
                        Text("Date of Birth")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .font(.system(size: 15))
                            .padding(.top, -55)
                        
                        HStack(spacing: 15) {
                            TextField("DD", text: $day)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(22)
                                .font(.system(size: 15))
                                .frame(width: 80, height: 35)
                                .multilineTextAlignment(.center)
                                .padding(.top, -56)
                            
                            TextField("MM", text: $month)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(22)
                                .font(.system(size: 15))
                                .frame(width: 80, height: 35)
                                .multilineTextAlignment(.center)
                                .padding(.top, -56)
                            
                            TextField("YYYY", text: $year)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(22)
                                .font(.system(size: 15))
                                .frame(width: 120, height: 35)
                                .multilineTextAlignment(.center)
                                .padding(.top, -56)
                        }
                        .padding(.horizontal, 30)
                        
                        Text("Gender")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                            .font(.system(size: 15))
                            .padding(.top, -35)
                        
                        HStack(spacing: 15) {
                                Button(action: {
                                    selectedGender = "Male"
                                }) {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .stroke(Color.gray, lineWidth: 2)
                                                .frame(width: 24, height: 24)
                                            
                                            if selectedGender == "Male" {
                                                Circle()
                                                    .fill(Color.black)
                                                    .frame(width: 12, height: 12)
                                            }
                                        }
                                        
                                        Text("Male")
                                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                                            .font(.system(size: 15))
                                    }
                                    .padding(10)
                                    .cornerRadius(22)
                                }
                                .padding(.top, -5)
                                
                                Button(action: {
                                    selectedGender = "Female"
                                }) {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .stroke(Color.gray, lineWidth: 2)
                                                .frame(width: 24, height: 24)
                                            
                                            if selectedGender == "Female" {
                                                Circle()
                                                    .fill(Color.black)
                                                    .frame(width: 12, height: 12)
                                            }
                                        }
                                        
                                        Text("Female")
                                            .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                                            .font(.system(size: 15))
                                    }
                                    .padding(10)
                                    .cornerRadius(22)
                                }
                                .padding(.top, -5)
                            }
                            .padding(.top, -43)
                            .padding(.leading, -100)
                        
                        Button(action: {
                            print("Next")
                        }) {
                            Text("Next")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .fontWeight(.bold)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                                .padding(.bottom, 30)
                        }
                        .padding(.horizontal, 30)
                    }
                    .padding(.top, -100)
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    VerificationView()
}
