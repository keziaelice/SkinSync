import SwiftUI
import SwiftData

// Model class for Product Data
@Model class ProductsData {
    var id: String
    var category: String
    var brand: String
    var productname: String
    var productdescription: String
    var skintype: String
    var ingredients: String
    var function: String
    var howtouse: String
    var link: String

    init(id: String, category: String, brand: String, productname: String, productdescription: String, skintype: String, ingredients: String, function: String, howtouse: String, link: String) {
        self.id = id
        self.category = category
        self.brand = brand
        self.productname = productname
        self.productdescription = productdescription
        self.skintype = skintype
        self.ingredients = ingredients
        self.function = function
        self.howtouse = howtouse
        self.link = link
    }
}

// Data loading and cleaning function
func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\"\n", with: "")
    return cleanFile
}

// Function to load products from CSV
func loadProducts() -> [ProductsData] {
    var listOfProducts = [ProductsData]()
    
    guard let filePath = Bundle.main.path(forResource: "productdata", ofType: "csv") else {
        print("CSV file not found")
        return []
    }
    print("File path: \(filePath)")
    
    var data = ""
    
    do {
        data = try String(contentsOfFile: filePath)
        
        // Clean the data
        data = cleanRows(file: data)
        
        // Split data by newlines
        var rows = data.components(separatedBy: .newlines)
        
        // Remove empty rows
        rows = rows.filter { !$0.isEmpty }
        
        // Ensure data exists
        guard let firstRow = rows.first else {
            print("No data found")
            return []
        }

        let columnCount = firstRow.components(separatedBy: ";").count
        print("Column count: \(columnCount)")  // Debugging column count
        
        rows.removeFirst()  // Remove header row

        // Process each row
        for (index, row) in rows.enumerated() {
            let columns = row.components(separatedBy: ";")
            
            // If the column count is correct, process the row
            if columns.count == columnCount {
                //print("Parsing row \(index): \(columns)")  // Debugging
                let thisProduct = ProductsData(id: columns[0],
                                               category: columns[1],
                                               brand: columns[2],
                                               productname: columns[3],
                                               productdescription: columns[4],
                                               skintype: columns[5],
                                               ingredients: columns[6],
                                               function: columns[7],
                                               howtouse: columns[8],
                                               link: columns[9])
                listOfProducts.append(thisProduct)
            } else {
                print(columns.count)
                print("Row \(index) skipped: \(columns)")  // Debugging skipped rows
            }
        }
    } catch {
        print(error)
        return []
    }
    
    return listOfProducts
}

// SwiftUI View
struct ProductsView: View {
    @Environment(\.modelContext) var modelContext
    @State private var products: [ProductsData] = loadProducts()  // Load products on view initialization

    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @FocusState private var searchBarFocused: Bool
    
    var filteredProducts: [ProductsData] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { product in
                ("\(product.brand) \(product.productname)").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
//        NavigationView {
            if products.isEmpty {
                Text("No products found in database")
                    .onAppear {
                        print("Products array is empty")
                    }
            } else {
                ZStack {
                    Color(red: 255/255, green: 250/255, blue: 246/255)
                        .ignoresSafeArea()
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(filteredProducts) { product in
                                    NavigationLink(destination: ProductDetailView(productId: product.id)) {
                                        ProductSquare(product: product, productid: product.id)
                                    }
                                }
                            }
                            .padding()
                            .padding(.bottom, 60)
                    }
                }
                .navigationTitle("Products")
                .navigationBarTitleDisplayMode(.large)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search products")
                .textInputAutocapitalization(.never)
                .focused($searchBarFocused).onAppear {
                    searchBarFocused = true // Activate the search bar programmatically
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        searchBarFocused = false // Deactivate to match intended behavior
                    }
                }
                .onChange(of: searchBarFocused) {
                    if $0 {
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
                .toolbarBackground(Color.backgroundColorElement, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
//        }
    }
}

// Product square view for displaying each product
struct ProductSquare: View {
    let product: ProductsData
    let productid: String
    @State private var imageExists = true

    var body: some View {
        VStack(alignment: .leading) {
            // Replace with actual image handling from ProductsData
            Group {
                        if imageExists {
                            Image("\(productid)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .onAppear {
                                    // Check if the image exists in the asset catalog
                                    if UIImage(named: "\(productid)") == nil {
                                        imageExists = false // Set the state to false if image doesn't exist
                                    }
                                }
                        } else {
                            Image(systemName: "photo")  // Fallback image if the original doesn't exist
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }



            Text((product.brand + " " + product.productname) ?? "Unknown Product") // Use product name
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .id(productid)
    }
}

#Preview {
    ProductsView()
}
