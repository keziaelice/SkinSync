//
//  HomeView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 06/12/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = "" // Search text for filtering
    @State private var isSearching = false // Track whether the search overlay is showing
    private let items = ["SKINTIFIC All Day Light Sunscreen Mist SPF50 PA++++ Sunscreen 50ml/120ml", "SKINTIFIC - 5X Ceramide Serum Sunscreen SPF50 PA++++ 30ml", "Light Serum Sunscreen SPF50 PA ++++25 ml", "SKINTIFIC - 360 Crystal Massager Lifting Eye Cream 20ML", "SKINTIFIC 10% Niacinamide Brightening Serum 20ML", "SKINTIFIC 2% Salicylic Acid Anti Acne Serum 20ML", "SKINTIFIC 5X Ceramide Barrier Repair Moisturize Gel 30G"]
        
    var filteredItems: [String] {
        if searchText.isEmpty {
            return []
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .ignoresSafeArea()
            
                ScrollView {
                VStack {
                    // Hello, Bobby
                    ZStack {
                        VStack {
                            Color(red: 161/255, green: 170/255, blue: 123/255)
                                .ignoresSafeArea(edges: .top)
                                .frame(height: 250)
                                .cornerRadius(15)
                                .padding(.top, -60)
                        }
                        VStack {
                            Text("Hello, Bobby")
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                                .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                            Text("How's your face condition?")
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 20)
                                .padding(.top, 0.1)
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)
                                TextField("Search tips, products...", text: $searchText)
                                    .font(.custom("Montserrat-Regular", size: 16))
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 4)
                        }
                        .padding(30)
                        .padding(.bottom, -70)
                        .padding(.top, -100)
                    }
                    
                    // Good Morning
                    HStack {
                        ZStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Good Morning")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                Text("Don't forget to use sunscreen and re-apply it every 3 hours")
                                    .frame(maxWidth: 200, minHeight: 40)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                Text("Start Skincare Routine")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                    .padding(.top, 20)
                            }
                            .padding(25)
                            Spacer()
                        }
                        Image("Sun")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .offset(x: 0, y: 40)
                    }
                    .background(Color(red: 236/255, green: 234/255, blue: 222/255))
                    .cornerRadius(20)
                    .padding()
                    .shadow(radius: 4)
                    
                    // Brands
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Brands")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading)
                            .padding(.bottom, -10)
                            .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5, id: \.self) { _ in
                                    Text("BRANDS")
                                        .font(.custom("Montserrat-Regular", size: 16))
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                        .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    //                ZStack {
                    //                    // Product
                    //                    VStack(alignment: .leading, spacing: 10) {
                    //                        Text("Product")
                    //                            .font(.system(size: 20, weight: .bold))
                    //                            .padding(.leading)
                    //                            .padding(.bottom, -10)
                    //                            .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                    //                        ScrollView(.horizontal, showsIndicators: false) {
                    //                            HStack(spacing: 16) {
                    //                                ForEach(0..<5, id: \.self) { _ in
                    //                                    Text("PRODUCT")
                    //                                        .font(.custom("Montserrat-Regular", size: 16))
                    //                                        .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                    //                                        .frame(width: 150, height: 150)
                    //                                        .background(Color.white)
                    //                                        .cornerRadius(10)
                    //                                        .shadow(radius: 4)
                    //                                }
                    //                            }
                    //                            .padding()
                    //                        }
                    //                    }
                    //                }
                    // Product Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Product")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading)
                            .padding(.bottom, -10)
                            .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5, id: \.self) { _ in
                                    
                                    Text("PRODUCT")
                                        .font(.custom("Montserrat-Regular", size: 16))
                                        .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                                        .frame(width: 150, height: 150)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                    
                                }
                            }
                            .padding()
                        }
                    }
                    
                    // Search Results Section (Separate from Search Bar)
                    if !filteredItems.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Search Results")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.leading)
                                .padding(.top)
                                .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                            List(filteredItems, id: \.self) { item in
                                Text(item)
                                    .foregroundColor(Color(red: 40/255, green: 51/255, blue:22/255))
                            }
                            .frame(height: 200) // Adjust list height
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
            }
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
