import SwiftUI

// Rename ProductListType to avoid conflicts
enum ScheduleProductListType {
    case morning, night
}

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
    
    @State private var selectedDay: String = ""
    @State private var listType: ScheduleProductListType = .morning
    @State private var showProductView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    productListView(listType: .morning)
                        .tabItem {
                            Label("Morning", systemImage: "sun.max.fill")
                        }
                    
                    productListView(listType: .night)
                        .tabItem {
                            Label("Night", systemImage: "moon.fill")
                        }
                }
                .navigationTitle("Schedule")
                .sheet(isPresented: $showProductView) {
                    ProductView(
                        availableProducts: ["3X Acid Acne Gel Cleanser", "SymWhite 377 Dark Spot Serum", "2% Salicylic Acid Anti Acne Serum", "5X Ceramide Barrier Serum"],
                        onSelectProduct: { product in
                            addProduct(product, to: listType, day: selectedDay)
                            showProductView = false
                        }
                    )
                }
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
    
    private func addProduct(_ product: String, to listType: ScheduleProductListType, day: String) {
        if listType == .morning {
            morningProducts[day]?.append(product)
        } else {
            nightProducts[day]?.append(product)
        }
    }
    
    private func deleteItem(from list: inout [String], at indexSet: IndexSet) {
        list.remove(atOffsets: indexSet)
    }
}

struct ProductView: View {
    let availableProducts: [String]
    let onSelectProduct: (String) -> Void
    
    var body: some View {
        NavigationView {
            List(availableProducts, id: \.self) { product in
                Button(action: {
                    onSelectProduct(product)
                }) {
                    Text(product)
                }
            }
            .navigationTitle("Select Product")
        }
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
            Spacer()
        }
        .padding(.vertical, 2)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct EditScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        EditScheduleView()
    }
}
