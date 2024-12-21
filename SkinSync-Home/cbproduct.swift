//
//  cbproduct.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 20/12/24.
//

import SwiftUI

struct cbproduct: View {
    @Environment(\.modelContext) var modelContext
    @State private var products: [ProductsData] = []

    var body: some View {
        VStack {
            Button(action: {
                loadAndInsertProducts()
            }) {
                Text("Load Products")
                    .padding()
                    .background(Color.blue)
            }
        }
        .padding()
        .onAppear {
            loadAndInsertProducts()
        }
    }
    
    func loadAndInsertProducts() {
        let productsFromCSV = loadProducts()
        for product in productsFromCSV {
            modelContext.insert(product)
        }
        products = productsFromCSV
    }
}

#Preview {
    cbproduct()
}
