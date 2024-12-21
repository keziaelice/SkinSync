//
//  ProductDetailView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 13/12/24.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.modelContext) var modelContext
    @State private var products: [ProductsData] = loadProducts()  // Load products on view initialization
    
    let productId: String
    var selectedProduct: ProductsData? {
        // Find the product with the matching productId
        products.first(where: { $0.id == productId })
    }
    
    var skintypes: [String] {
        selectedProduct?.skintype
            .split(separator: ", ")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) } ?? []
    }
    
    var ingredients: [String] {
        selectedProduct?.ingredients
            .split(separator: "#")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) } ?? []
    }
    
    var steps: [String] {
        selectedProduct?.howtouse
            .split(separator: "#")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) } ?? []
    }


    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 246/255)
                .ignoresSafeArea()
            ZStack {
                VStack {
                    Color.backgroundColorElement
                }
                .frame(height: 200, alignment: .top)
                .padding(.top, -472)
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        // Product image and title
                        Image("\(productId)") // Replace with actual product image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .background(Color(.backgroundColorPage))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.horizontal)
                            .onAppear {
                                print(productId)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text("\(selectedProduct?.brand ?? "Unknown Brand") \(selectedProduct?.productname ?? "Unknown Product")")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Product description
                    ScrollView {
                        // ScrollView untuk Tags
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(skintypes, id: \.self) { skintype in
                                    TagView(text: skintype, color: getTagColor(for: skintype))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(ingredients, id: \.self) { ingredient in
                                    TagView(text: ingredient, color: Color(.backgroundColorElement))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 15)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Description")
//                                .font(.body)
                                .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, -10)
                            Text("""
                            \(selectedProduct?.productdescription ?? "No description available.")
                            """)
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
//                            .fixedSize(horizontal: false, vertical: false) // Teks menyesuaikan tinggi
                            
                            // Spacer agar memastikan tidak ada tambahan padding jika teks lebih pendek
//                            Spacer(minLength: 0)
                            
                            Text("How to Use")
//                                .font(.body)
                                .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, -10)
                            ForEach(steps, id: \.self) { step in
                                    HStack(alignment: .top) {
                                        Text("•") // Bullet point
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .padding(.leading, 5)
                                        Text(step) // Step description
                                            .font(.body)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.bottom, -10)
                                }
                                .padding(.horizontal)
//                            .font(.body)
//                            .foregroundColor(.gray)
//                            .padding(.horizontal)
//                            .fixedSize(horizontal: false, vertical: false)
                            
                        }
                        .padding(.bottom, 20)
//                        .frame(maxHeight: 250) // Maksimum tinggi ScrollView
                    }
//                    .background(Color.clear) // Opsional, jika ingin transparan

                    
                    
//                    Text("Related Products")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        .multilineTextAlignment(.center)
//                    .padding(.horizontal)
                    // ScrollView untuk Related Products
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 16) {
//                            RelatedProductView()
//                            RelatedProductView()
//                            RelatedProductView()
//                        }
//                        .padding(.horizontal)
//                    }

                    // Spacer untuk sisa ruang di bawah
//                    Spacer()
//                    Spacer()


                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20) // Adjust for safe area
                //            .background(Color(red: 161/255, green: 170/255, blue: 123/255).edgesIgnoringSafeArea(.all))
            }
        }
        .padding(.top, -70)
        .frame(maxHeight: 702)
        .padding(.bottom, 5)
    }
    
    func getTagColor(for skintype: String) -> Color {
        switch skintype.lowercased() {
        case "oily":
                return Color.green
            case "acne-prone", "acne":
                return Color.red
            case "combination":
                return Color.purple
            case "dry":
                return Color.orange
            case "sensitive":
                return Color.pink
            case "normal":
                return Color.blue
            case "very dry":
                return Color.brown
            case "all":
                return Color.gray
            default:
                return Color.black
            }
        }
}

// Custom tag view
struct TagView: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(8)
            .background(color.opacity(0.2))
            .foregroundColor(color)
            .cornerRadius(8)
    }
}

// Related product card
//struct RelatedProductView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "photo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 100)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//            
//            Text("Skintific 5X Ceramide")
//                .font(.headline)
//                .lineLimit(1)
//        }
//        .frame(width: 120)
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
//    }
//}

#Preview {
    ProductDetailView(productId: "P1")
}
