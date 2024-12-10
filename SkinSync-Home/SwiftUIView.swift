import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab = 0 // Track selected tab index
    
    var body: some View {
        ZStack {
            Group {
                if selectedTab == 0 {
                    ScheduleView()
                } else if selectedTab == 1 {
//                                    SearchView()
                } else if selectedTab == 2 {
                    ContentView()
                }
            }
            VStack {
                // Main Content View based on selected tab
                Spacer()
                Text("Selected Tab: \(selectedTab == 0 ? "Home" : selectedTab == 1 ? "Search" : "Profile")")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Spacer()
            }
            
            VStack {
                Spacer()
                // Custom Tab Bar with Rounded Corners
                HStack {
                    Spacer()
                    CustomTabBarButton(icon: "house", filledIcon: "house.fill", selected: selectedTab == 0)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 0
                            }
                        }
                    Spacer()
                    CustomTabBarButton(icon: "magnifyingglass", filledIcon: "magnifyingglass.circle.fill", selected: selectedTab == 1)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 1
                            }
                        }
                    Spacer()
                    CustomTabBarButton(icon: "person", filledIcon: "person.fill", selected: selectedTab == 2)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = 2
                            }
                        }
                    Spacer()
                }
                .padding()
                .background(Color(red: 161/255, green: 170/255, blue: 123/255)) // Green color for the tab bar
                .cornerRadius(25, corners: [.topLeft, .topRight]) // Rounded corners at the top
                .padding(.bottom, 0) // Remove extra space below the tab bar
                .ignoresSafeArea(edges: .bottom) // Extend to the bottom edge to fill the space
            }
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the entire layout ignores the bottom safe area
    }
}

struct CustomTabBarButton2: View {
    var icon: String
    var filledIcon: String
    var selected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: selected ? filledIcon : icon) // Switch between filled and regular icon
                .font(.system(size: 24))
                .foregroundColor(selected ? Color(red: 236/255, green: 234/255, blue: 222/255) : .gray) // Use custom color for selection
            
            Text(icon == "house" ? "Home" : icon == "magnifyingglass" ? "Search" : "Profile")
                .font(.caption)
                .foregroundColor(selected ? Color(red: 236/255, green: 234/255, blue: 222/255) : .gray) // Use custom color for selection
        }
    }
}

extension View {
    func cornerRadius2(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner2: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    CustomTabView()
}
