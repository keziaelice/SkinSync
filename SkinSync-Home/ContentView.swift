//
//  ContentView.swift
//  SkinSync-Home
//
//  Created by student on 20/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var username = ""
    @State private var selectedTab = 0 // Track selected tab index
    
    init() {
        // Customize the appearance of the tab bar
        UITabBar.appearance().backgroundColor = UIColor(Color.backgroundColorElement) // Tab bar background color
        UITabBar.appearance().tintColor = UIColor.red // Selected tab color
    }
    
    var body: some View {
        ZStack {
            Group {
                if (true) {
                    
                }
                
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
                .background(Color.backgroundColorElement) // Green color for the tab bar
                .cornerRadius(25, corners: [.topLeft, .topRight]) // Rounded corners at the top
                .ignoresSafeArea(edges: .bottom) // Extend to the bottom edge to fill the space
            }
            .padding(.top, 10)
            .padding(.bottom, -34) // Remove extra space below the tab bar
        }
    }
}

struct CustomTabBarButton: View {
    var icon: String
    var filledIcon: String
    var selected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: selected ? filledIcon : icon) // Switch between filled and regular icon
                .font(.system(size: 24))
                .foregroundColor(selected ? Color(red: 40/255, green: 51/255, blue:22/255) : Color(red: 40/255, green: 51/255, blue:22/255)) // Use custom color for selection
            
            Text(icon == "house" ? "Home" : icon == "calendar" ? "Schedule" : icon == "face.smiling" ? "Analyze" : "Profile")
                .font(.caption)
                .foregroundColor(selected ? Color(red: 40/255, green: 51/255, blue:22/255) : Color(red: 40/255, green: 51/255, blue:22/255)) // Use custom color for selection
                .padding(.bottom, 10)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    HomeView()
}
