import SwiftUI

struct SearchableExampleView: View {
    @State private var searchText: String = ""
    private let items = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"]

    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Fruits")
            .searchable(text: $searchText, prompt: "Search fruits")
            .textInputAutocapitalization(.never) // Disable auto-capitalization
        }
    }
}

struct SearchableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableExampleView()
    }
}
