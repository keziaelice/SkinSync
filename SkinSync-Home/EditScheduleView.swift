import SwiftUI

struct EditScheduleView: View {
    @State private var morningProducts: [String: [String]] = [
        "Monday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Tuesday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Wednesday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Thursday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Friday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Saturday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"],
        "Sunday": ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum"]
    ]
    
    @State private var nightProducts: [String: [String]] = [
        "Monday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Tuesday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Wednesday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Thursday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Friday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Saturday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
        "Sunday": ["2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"]
    ]

    var body: some View {
        NavigationView {
            VStack {
                // TabView for Morning and Night
                TabView {
                    // Morning Products Tab
                    VStack {
                        List {
                            ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                                Section(header: Text(day).font(.headline)) {
                                    ForEach(morningProducts[day] ?? [], id: \.self) { product in
                                        ProductCard(product: product, listType: .morning)
                                    }
                                    .onDelete { indexSet in
                                        deleteItem(from: &morningProducts[day]!, at: indexSet)
                                    }
                                    Button(action: {
                                        addNewItem(to: .morning, day: day)
                                    }) {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.blue)
                                            Text("Add New Item")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                    .tabItem {
                        Label("Morning", systemImage: "sun.max.fill")
                    }

                    // Night Products Tab
                    VStack {
                        List {
                            ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                                Section(header: Text(day).font(.headline)) {
                                    ForEach(nightProducts[day] ?? [], id: \.self) { product in
                                        ProductCard(product: product, listType: .night)
                                    }
                                    .onDelete { indexSet in
                                        deleteItem(from: &nightProducts[day]!, at: indexSet)
                                    }
                                    Button(action: {
                                        addNewItem(to: .night, day: day)
                                    }) {
                                        HStack {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.blue)
                                            Text("Add New Item")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                    .tabItem {
                        Label("Night", systemImage: "moon.fill")
                    }
                }
                .navigationTitle("Schedule")
                .navigationBarBackButtonHidden(true) // Hide the back button
            }
        }
    }

    // Function to add a new item to the Morning or Night products for a specific day
    private func addNewItem(to listType: ProductListType, day: String) {
        let newProduct = "New Product \(listType == .morning ? morningProducts[day]!.count + 1 : nightProducts[day]!.count + 1)"
        if listType == .morning {
            morningProducts[day]?.append(newProduct)
        } else {
            nightProducts[day]?.append(newProduct)
        }
    }

    // Function to delete an item from the list
    private func deleteItem(from list: inout [String], at indexSet: IndexSet) {
        list.remove(atOffsets: indexSet)
    }
}

// Enum to determine whether the new product is for Morning or Night
enum ProductListType {
    case morning, night
}

// Card view for each product
struct ProductCard: View {
    var product: String
    var listType: ProductListType

    var body: some View {
        HStack {
            Text(product)
                .font(.body)
                .padding(.leading, -0)  // Remove leading padding to align text directly to the left
            Spacer()
        }
        .padding(.vertical, 2)  // Reduced vertical padding for closer spacing
        .background(Color.white)
        .cornerRadius(10)
        .padding(.leading, 0)
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView()
    }
}
