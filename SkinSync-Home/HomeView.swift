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
    
    
//    @Query(sort: \ProductsData.productname) var products: [ProductsData] // Fetch all products from the database
//        
    @State private var randomProducts: [ProductsData] = [] // Store random products
    
    
    @Environment(\.modelContext) var modelContext
    @State private var products: [ProductsData] = loadProducts()  // Load products on view initialization
    
    // Function to select random products
    func selectRandomProducts() {
        // Shuffle products and select first 10 random products
        randomProducts = products.shuffled().prefix(10).map { $0 }
    }
    
//    @Bindable var user: UserModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .ignoresSafeArea()
                
                //ScrollView {
                    VStack {
                        // Hello, Bobby
                        ZStack {
                            VStack {
                                Color.backgroundColorElement
                                    .ignoresSafeArea(edges: .top)
                                    .frame(height: 200)
                                    .cornerRadius(25)
                                    .padding(.top, -63)
                            }
                            VStack {
                                Text("Hello, \(username)")
                                    .fontWeight(.bold)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.colorText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 50)
                                Text("How's your face condition?")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.colorText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 20)
                                    .padding(.top, 0.1)
                            }
                            .padding(30)
                            .padding(.bottom, -70)
                            .padding(.top, -100)
                        }
                        ScrollView {
                        // Good Morning
                        HStack {
                            ZStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Good Morning")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(Color.colorText)
                                    Text("Don't forget to use sunscreen and re-apply it every 3 hours")
                                        .frame(maxWidth: .infinity, minHeight: 40)
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
                                            .frame(width: 150, height: 150)
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
                                    HStack {
                                        Text("See All")
                                            .foregroundColor(Color.colorText)
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.colorText)
                                            .padding(.trailing, 15)
                                    }
                                }
                            }
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                    ForEach(randomProducts, id: \.id) { product in
                                        NavigationLink(destination: ProductDetailView(productId: product.id)) {
                                            ProductSquare(product: product, productid: product.id)
                                        }
                                    }
                                }
                                .padding()
                                .padding(.bottom, 60)
                            }
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 16) {
//                                    ForEach(0..<5, id: \.self) { _ in
//                                        
//                                        Text("PRODUCT")
//                                            .font(.custom("Montserrat-Regular", size: 16))
//                                            .foregroundColor(Color.colorText)
//                                            .frame(width: 150, height: 150)
//                                            .background(Color.white)
//                                            .cornerRadius(10)
//                                            .shadow(radius: 4)
//                                        
//                                    }
//                                }
//                                .padding()
//                            }
                        }
                    }
                        .padding(.top, -8)
                }
            }
        }
        .tint(Color.colorText)
        .onAppear {
            selectRandomProducts() // Select random products when the view appears
        }

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
