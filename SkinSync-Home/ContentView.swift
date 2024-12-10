//
//  ContentView.swift
//  SkinSync-Home
//
//  Created by student on 20/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0 // Track selected tab index
    
    init() {
        // Customize the appearance of the tab bar
        UITabBar.appearance().backgroundColor = UIColor(Color(red: 161/255, green: 170/255, blue: 123/255)) // Tab bar background color
        UITabBar.appearance().tintColor = UIColor.red // Selected tab color
    }
    
    var body: some View {
        ZStack {
            Group {
                if selectedTab == 0 {
                    HomeView()
                } else if selectedTab == 1 {
                    ScheduleView()
                } else if selectedTab == 2 {
                    ProductsView()
                } else if selectedTab == 3 {
                    ProfileView()
                }
            }
            VStack {
                Spacer()
                // Custom Tab Bar with Rounded Corners
                HStack {
                    Spacer()
                    CustomTabBarButton(icon: "house", filledIcon: "house.circle.fill", selected: selectedTab == 0)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 0
                            }
                        }
                    Spacer()
                    CustomTabBarButton(icon: "calendar", filledIcon: "calendar.circle.fill", selected: selectedTab == 1)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 1
                            }
                        }
                    Spacer()
                    CustomTabBarButton(icon: "face.smiling", filledIcon: "face.smiling.fill", selected: selectedTab == 2)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 2
                            }
                        }
                    Spacer()
                    CustomTabBarButton(icon: "person", filledIcon: "person.circle.fill", selected: selectedTab == 3)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 3
                            }
                        }
                    Spacer()
                }
                .padding()
                .background(Color(red: 161/255, green: 170/255, blue: 123/255)) // Green color for the tab bar
                .cornerRadius(25, corners: [.topLeft, .topRight]) // Rounded corners at the top
                .padding(.bottom, -32) // Remove extra space below the tab bar
                .ignoresSafeArea(edges: .bottom) // Extend to the bottom edge to fill the space
            }
        }
    }
}

#Preview {
    HomeView()
}
