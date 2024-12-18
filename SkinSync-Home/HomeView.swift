//
//  HomeView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 06/12/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let username: String // Accept username as a parameter
    
//    @Bindable var user: UserModel
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
        NavigationView {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        // Hello, Bobby
                        ZStack {
                            VStack {
                                Color.backgroundColorElement
                                    .ignoresSafeArea(edges: .top)
                                    .frame(height: 250)
                                    .cornerRadius(15)
                                    .padding(.top, -63)
                            }
                            VStack {
                                Text("Hello, \(username)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.colorText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 20)
                                Text("How's your face condition?")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.colorText)
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
                                        .foregroundColor(Color.colorText)
                                    Text("Don't forget to use sunscreen and re-apply it every 3 hours")
                                        .frame(maxWidth: 200, minHeight: 40)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.colorText)
                                    Text("Start Skincare Routine")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color.colorText)
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
                                .foregroundColor(Color.colorText)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<5, id: \.self) { _ in
                                        Text("BRANDS")
                                            .font(.custom("Montserrat-Regular", size: 16))
                                            .frame(width: 100, height: 100)
                                            .background(Color.white)
                                            .foregroundColor(Color.colorText)
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
                        //                            .foregroundColor(Color.colorText)
                        //                        ScrollView(.horizontal, showsIndicators: false) {
                        //                            HStack(spacing: 16) {
                        //                                ForEach(0..<5, id: \.self) { _ in
                        //                                    Text("PRODUCT")
                        //                                        .font(.custom("Montserrat-Regular", size: 16))
                        //                                        .foregroundColor(Color.colorText)
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
                            HStack {
                                Text("Products")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.leading)
                                    .padding(.bottom, -10)
                                    .foregroundColor(Color.colorText)
                                Spacer()
                                NavigationLink(destination: ProductsView()) {
                                    Text("See All")
                                        .foregroundColor(Color.colorText)
                                        .padding(.trailing, 15)
                                }
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<5, id: \.self) { _ in
                                        
                                        Text("PRODUCT")
                                            .font(.custom("Montserrat-Regular", size: 16))
                                            .foregroundColor(Color.colorText)
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
                                    .foregroundColor(Color.colorText)
                                List(filteredItems, id: \.self) { item in
                                    Text(item)
                                        .foregroundColor(Color.colorText)
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
        .tint(Color.colorText)
    }
}

#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: UserModel.self, configurations: config)
//        let createdUser = UserModel(username: "Example Username", age: 10, gender: "Example Gender")
//        return HomeView(user: createdUser)
//            .modelContainer(container)
//    }
//    catch {
//        fatalError("Failed to create model container. ")
//    }
    
    
    HomeView(username: "Guest")
}
