//
//  ProductDetailView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 13/12/24.
//

import SwiftUI

struct ProductDetailView: View {
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
                        Image("Sun") // Replace with actual product image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .background(Color(.backgroundColorElement))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    
                    Text("Skintific 2% Salicylic Acid Anti Acne Serum 20ml")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    
                    // ScrollView untuk Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            TagView(text: "retinol", color: .orange)
                            TagView(text: "Vitamin C", color: .yellow)
                            TagView(text: "Vitamin C", color: .yellow)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Product description
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("""
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea coon proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                            """)
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: false) // Teks menyesuaikan tinggi
                            
                            // Spacer agar memastikan tidak ada tambahan padding jika teks lebih pendek
//                            Spacer(minLength: 0)
                        }
//                        .frame(maxHeight: 250) // Maksimum tinggi ScrollView
                    }
//                    .background(Color.clear) // Opsional, jika ingin transparan

                    
                    Text("Related Products")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    // ScrollView untuk Related Products
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            RelatedProductView()
                            RelatedProductView()
                            RelatedProductView()
                        }
                        .padding(.horizontal)
                    }

                    // Spacer untuk sisa ruang di bawah
                    Spacer()


                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20) // Adjust for safe area
                //            .background(Color(red: 161/255, green: 170/255, blue: 123/255).edgesIgnoringSafeArea(.all))
            }
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
struct RelatedProductView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            Text("Skintific 5X Ceramide")
                .font(.headline)
                .lineLimit(1)
        }
        .frame(width: 120)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ProductDetailView()
}
