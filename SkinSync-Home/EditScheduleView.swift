import SwiftUI
// Rename ProductListType to avoid conflicts
enum ScheduleProductListType {
    case morning, night
}
struct EditScheduleView: View {
    @State private var morningProducts: [String: [String]] = [
        "Monday": [],
        "Tuesday": [],
        "Wednesday": [],
        "Thursday": [],
        "Friday": [],
        "Saturday": [],
        "Sunday": []
    ]
    
    @State private var nightProducts: [String: [String]] = [
        "Monday": [],
        "Tuesday": [],
        "Wednesday": [],
        "Thursday": [],
        "Friday": [],
        "Saturday": [],
        "Sunday": []
    ]
    
    @State private var selectedDay: String = ""
    @State private var listType: ScheduleProductListType = .morning
    @State private var showProductView: Bool = false
    @State private var showIncompatibleAlert = false
    @State private var incompatibleMessage = ""
    
    let incompatibilityRules: [String: [String]] = [
        "AHA": ["Retinol", "Vitamin C"],
        "BHA": ["Retinol", "Vitamin C"],
        "Retinol": ["Vitamin C", "AHA", "BHA", "Benzoyl Peroxide"],
        "Vitamin C": ["Retinol", "AHA", "BHA", "Benzoyl Peroxide"],
        "Niacinamide": ["Vitamin C"],
        "Benzoyl Peroxide": ["Vitamin C", "Retinol"],
        "SPF": ["Retinol"]
    ]
    
    let timeSpecificRules: [ScheduleProductListType: [String: [String]]] = [
        .morning: [
            "Retinol": ["morning"],
            "AHA": ["morning"],
            "BHA": ["morning"],
        ],
        .night: [
            "SPF": ["night"],
            "UV Filters": ["night"]
        ]
    ]
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color.backgroundColorPage
                        .ignoresSafeArea()
                VStack {
                    // Segmented control for day and night schedule
                    Picker("Schedule Type", selection: $listType) {
                        Text("Morning").tag(ScheduleProductListType.morning)
                        Text("Night").tag(ScheduleProductListType.night)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.backgroundColorPage)
                    
                    // Main content (TabView updated for listType toggle)
                    productListView(listType: listType)
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Schedule").toolbarBackground(Color.backgroundColorElement, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                    
                        .sheet(isPresented: $showProductView) {
                            let selectedProducts = listType == .morning
                            ? morningProducts[selectedDay] ?? []
                            : nightProducts[selectedDay] ?? []
                            let allSelectedProducts = listType == .morning ? morningProducts : nightProducts
                            ProductsViewSchedule(
                                onSelectProduct: { product in
                                    addProduct(product, to: listType, day: selectedDay)
                                    showProductView = false
                                },
                                selectedProducts: selectedProducts,
                                allSelectedProducts: allSelectedProducts
                            )
                        }
                        .alert(isPresented: $showIncompatibleAlert) {
                            Alert(
                                title: Text("Warning"),
                                message: Text(incompatibleMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                }
                .padding(.bottom, 60)
                    
            }
        }
    }
    
    private func productListView(listType: ScheduleProductListType) -> some View {
        let products = listType == .morning ? morningProducts : nightProducts
        
        return List {
            ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                Section(header: Text(day).font(.headline)) {
                    ForEach(products[day] ?? [], id: \.self) { product in
                        ProductCard(product: product, listType: listType)
                    }
                    .onDelete { indexSet in
                        if listType == .morning {
                            deleteItem(from: &morningProducts[day]!, at: indexSet)
                        } else {
                            deleteItem(from: &nightProducts[day]!, at: indexSet)
                        }
                    }
                    
                    Button(action: {
                        selectedDay = day
                        self.listType = listType
                        showProductView = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                            Text("Add New Item")
                                .foregroundColor(Color(red: 161/255, green: 170/255, blue: 123/255))
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.backgroundColorPage)
        .scrollContentBackground(.hidden)
    }
    
    func extractIngredients(for product: String, from allProducts: [ProductsData]) -> [String] {
        if let matchingProduct = allProducts.first(where: { "\($0.brand) \($0.productname)" == product }) {
            print("Found product: \(matchingProduct.productname), Ingredients: \(matchingProduct.ingredients)")
            
            var ingredients = matchingProduct.ingredients.components(separatedBy: ", ")
            
            let keywords = ["Vitamin C", "Retinol", "Niacinamide", "AHA", "BHA", "PHA", "Benzoyl Peroxide", "SPF", "UV Filters"]
            
            for keyword in keywords {
                if product.localizedCaseInsensitiveContains(keyword), !ingredients.contains(keyword) {
                    ingredients.append(keyword)
                }
            }
            
            return ingredients
        }
        print("Product not found: \(product)")
        return []
    }
    
    func areIngredientsCompatible(ingredientA: String, ingredientB: String) -> Bool {
        if let incompatibleWithA = incompatibilityRules[ingredientA] {
            if incompatibleWithA.contains(ingredientB) {
                return false
            }
        }
        if let incompatibleWithB = incompatibilityRules[ingredientB] {
            if incompatibleWithB.contains(ingredientA) {
                return false
            }
        }
        return true     }
    
    private func addProduct(_ product: String, to listType: ScheduleProductListType, day: String) {
        let currentProducts = listType == .morning ? morningProducts[day] ?? [] : nightProducts[day] ?? []
        let allProducts = loadProductsSchedule()
        let productIngredients = extractIngredients(for: product, from: allProducts)
        // Check time-specific rules for morning or night
        for ingredient in productIngredients {
            if let restrictions = timeSpecificRules[listType]?[ingredient], restrictions.contains(listType == .morning ? "morning" : "night") {
                incompatibleMessage = "\(ingredient) should not be used in the \(listType == .morning ? "morning" : "night")."
                DispatchQueue.main.async {
                    showIncompatibleAlert = true
                }
                return
            }
        }
        // Compatibility check with existing products
        for existingProduct in currentProducts {
            let existingIngredients = extractIngredients(for: existingProduct, from: allProducts)
            for ingredientA in productIngredients {
                for ingredientB in existingIngredients {
                    if !areIngredientsCompatible(ingredientA: ingredientA, ingredientB: ingredientB) {
                        incompatibleMessage = "Cannot add product because \(ingredientA) is incompatible with \(ingredientB)."
                        DispatchQueue.main.async {
                            showIncompatibleAlert = true
                        }
                        return
                    }
                }
            }
        }
        // Add product to the appropriate list
        if listType == .morning {
            if !currentProducts.contains(product) {
                morningProducts[day]?.append(product)
            }
        } else {
            if !currentProducts.contains(product) {
                nightProducts[day]?.append(product)
            }
        }
    }
    
    private func deleteItem(from list: inout [String], at indexSet: IndexSet) {
        list.remove(atOffsets: indexSet)
    }
}
// Function to load products from CSV
func loadProductsSchedule() -> [ProductsData] {
    var listOfProducts = [ProductsData]()
    
    guard let filePath = Bundle.main.path(forResource: "productdata", ofType: "csv") else {
        print("CSV file not found")
        return []
    }
    print("File path: \(filePath)")
    
    var data = ""
    
    do {
        data = try String(contentsOfFile: filePath)
        
        data = cleanRows(file: data)
        
        var rows = data.components(separatedBy: .newlines)
        
        rows = rows.filter { !$0.isEmpty }
        
        guard let firstRow = rows.first else {
            print("No data found")
            return []
        }
        let columnCount = firstRow.components(separatedBy: ";").count
        print("Column count: \(columnCount)")
        
        rows.removeFirst()
        for (index, row) in rows.enumerated() {
            let columns = row.components(separatedBy: ";")
            
            if columns.count == columnCount {
                print("Parsing row \(index): \(columns)")  // Debugging
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
struct ProductsViewSchedule: View {
    let onSelectProduct: (String) -> Void
    let selectedProducts: [String] // Pass selected products
    let allSelectedProducts: [String: [String]]
    
    
    @Environment(\.modelContext) var modelContext
    @State private var products: [ProductsData] = loadProducts()  // Load products on view initialization
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @FocusState private var searchBarFocused: Bool
    
    var filteredProducts: [ProductsData] {
        if searchText.isEmpty {
            return products.filter { product in
                !allSelectedProducts.values.flatMap { $0 }.contains(product.productname) &&
                !selectedProducts.contains(product.productname)
            }
        } else {
            return products.filter { product in
                !allSelectedProducts.values.flatMap { $0 }.contains(product.productname) &&
                !selectedProducts.contains(product.productname) &&
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
                    Color.backgroundColorPage
                        .ignoresSafeArea()
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredProducts) { product in
                                Button(action: {
                                    let formattedProductName = "\(product.brand) \(product.productname)"
                                    onSelectProduct(formattedProductName) // Notify parent view
                                    products.removeAll { $0.productname == product.productname } // Remove from available list
                                }) {
                                    ProductSquareSchedule(product: product, productid: product.id)
                                }
                                
                                
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Select Product")
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                }
                .navigationTitle("x")
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
struct ProductSquareSchedule: View {
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
                .foregroundColor(Color.colorText)
        }
        .padding()
        .background(Color.backgroundColorPage)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .id(productid)
    }
}
// Rename ProductCard to avoid conflicts
struct ProductCard: View {
    var product: String
    var listType: ScheduleProductListType
    
    var body: some View {
        HStack {
            Text(product)
                .font(.body)
                .foregroundColor(Color.colorText)
            Spacer()
        }
        .padding(.vertical, 2)
        .cornerRadius(10)
    }
}
struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView()
    }
}

