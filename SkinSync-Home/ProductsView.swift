import SwiftUI

struct ProductsView: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false // Determines if search bar is active
    @State private var searchHistory: [String] = [
        "History Search 1",
        "History Search 2",
        "History Search 3",
        "History Search 4",
        "History Search 5"
    ]
    @FocusState private var searchBarFocused: Bool // Tracks whether the search bar is focused
    
    var products: [String] = (1...12).map { "Skintific 2% Salicylic Acid Anti Acne Serum 20ml #\($0)" }
    
    var filteredProducts: [String] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if isSearching {
                    if searchText.isEmpty {
                        // Show search history when no text is entered
                        List {
                            Section(header: Text("Search History")) {
                                ForEach(searchHistory, id: \.self) { history in
                                    HStack {
                                        Image(systemName: "clock")
                                        Text(history)
                                        Spacer()
                                        Button(action: {
                                            if let index = searchHistory.firstIndex(of: history) {
                                                searchHistory.remove(at: index)
                                            }
                                        }) {
                                            Image(systemName: "xmark.circle")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        searchText = history
                                        searchBarFocused = false // Close search bar
                                    }
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    } else {
                        // Show filtered products
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(filteredProducts, id: \.self) { product in
                                    VStack(alignment: .leading) {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 150)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                        
                                        Text(product)
                                            .font(.headline)
                                            .lineLimit(2)
                                        
                                        HStack {
                                            Text("retinol")
                                                .font(.caption)
                                                .padding(4)
                                                .background(Color.orange.opacity(0.2))
                                                .cornerRadius(4)
                                            Text("Vitamin C")
                                                .font(.caption)
                                                .padding(4)
                                                .background(Color.yellow.opacity(0.2))
                                                .cornerRadius(4)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                }
                            }
                            .padding()
                        }
                    }
                } else {
                    // Show all products when not searching
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(products, id: \.self) { product in
                                VStack(alignment: .leading) {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    
                                    Text(product)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    HStack {
                                        Text("retinol")
                                            .font(.caption)
                                            .padding(4)
                                            .background(Color.orange.opacity(0.2))
                                            .cornerRadius(4)
                                        Text("Vitamin C")
                                            .font(.caption)
                                            .padding(4)
                                            .background(Color.yellow.opacity(0.2))
                                            .cornerRadius(4)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Products")
            .searchable(text: $searchText, prompt: "Search products")
            .textInputAutocapitalization(.never)
            .focused($searchBarFocused) // Attach focus binding
            .onChange(of: searchBarFocused) {
                if $0 { // $0 is the new value of searchBarFocused
                    isSearching = true
                } else {
                    isSearching = false
                    searchText = ""
                }
            }

            .onChange(of: searchText) {
                if $0.isEmpty {
                    isSearching = true
                } else {
                    isSearching = true
                }
            }

            .onSubmit {
                // Save to search history on submit
                if !searchText.isEmpty && !searchHistory.contains(searchText) {
                    searchHistory.insert(searchText, at: 0)
                }
                searchBarFocused = false // Dismiss keyboard
            }
            .toolbarBackground(Color(red: 161/255, green: 170/255, blue: 123/255), for: .navigationBar) // Set green background
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
