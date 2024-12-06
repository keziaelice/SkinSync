//
//  ContentView.swift
//  Skincare routine
//
//  Created by MacBook Pro on 26/11/24.
//
import SwiftUI
struct ContentViewSkincare: View {
    var body: some View {
        NavigationView {
            SkincareRoutineView()
        }
    }
}
struct SkincareRoutineView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("SKINCARE ROUTINE 1")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(20)
            
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(red: 161/255, green: 170/255, blue: 123/255))
                .background(Circle().fill(Color(red: 161/255, green: 170/255, blue: 123/255)))
        
            
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(40)
            
            
            Spacer()
            
            NavigationLink(destination: CheckmarkView()) {
                Text("Finish")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 161/255, green: 170/255, blue: 123/255))
                            .shadow(radius: 2)
                    )
                    .padding(.horizontal)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
    
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        })
    }
}
struct CheckmarkView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                )
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    ContentViewSkincare()
}


