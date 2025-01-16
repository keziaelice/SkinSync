import SwiftUI
import SwiftData

struct ResultView: View {
    let answers: [String: String]
    let selectedImage: UIImage?
    var isAcneDetect: Bool
    @State private var filteredProducts: [ProductsData] = []
    @State private var recommendedProducts: [ProductsData] = []
    
    @Query var users: [UserModel]
    
    let products: [ProductsData] = loadProducts()
    let questions: [Question] = loadQuestions() // Load the JSON data
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                Text("Your Analysis")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding()
                    .foregroundColor(Color(red: 25/255, green: 48/255, blue: 115/255))
                
                // Show image if selected
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 320)
                        .cornerRadius(40)
                }
                
                if isAcneDetect {
                    Text("Based on the Face Analysis, acne detected on the face")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    Text("Based on the Face Analysis, There are no acne detected.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Display advice based on answers
                Text("Advice")
                    .font(.title2)
                    .padding(.top, 16)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 25/255, green: 48/255, blue: 115/255))
                
                // Display relevant advice based on answers
                VStack(alignment: .center, spacing: 12) {
                    ForEach(questions) { question in
                        if let answer = answers[question.title], let advice = question.advice?[answer] {
                            Text(advice)
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding(.bottom, 16)
                
                Divider()
                    .padding(.vertical, 16)
                
                // Display recommended products
                Text("Recommended Products")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding()
                    .foregroundColor(Color(red: 25/255, green: 48/255, blue: 115/255))
                
                if recommendedProducts.isEmpty {
                    Text("No products match your preferences at this time.")
                        .font(.body)
                        .foregroundColor(.gray)
                } else {
                    ForEach(recommendedProducts, id: \.id) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Image("\(product.id)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                                .cornerRadius(4)
                            
                            Text("\(product.productname)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("\(product.productdescription)")
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            Text("Skin Types: \(product.skintype)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text("Ingredients: \(product.ingredients)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Link("View Product", destination: URL(string: product.link)!)
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                        .padding()
                    }
                }
            }
            .padding(.bottom, 60)
        }
        .onAppear {
            // Update recommended products when view appears
            recommendedProducts = recommendProducts(answers: answers, products: products)
                print("isAcneDetect onAppear:", isAcneDetect)
                
        }
    }
    
    // Function to recommend products based on answers
    func recommendProducts(answers: [String: String], products: [ProductsData]) -> [ProductsData] {
        guard let user = users.first else { return [] } // Safely get the first user
        
        let skinType = answers["skinType"]?.lowercased()
        let primaryConcern = answers["primaryConcern"]?.lowercased()
        let allergies = answers["allergies"]?.lowercased().split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } ?? []
        let isPregnantOrBreastfeeding = (answers["pregnantOrBreastfeeding"]?.lowercased() == "yes")
        
        let unsafeIngredientsForPregnancy: [String] = [
            "retinoids", "retinol", "salicylic acid", "benzoyl peroxide", "hydroquinone", "formaldehyde", "chemical sunscreens", "essential oils (certain types)"
        ]
        
        let unsafeIngredientsForTeens: [String] = [
            "retinoids", "retinol", "hydroquinone", "parabens"
        ]
        
        // Filter products based on user preferences
        let filteredProducts = products.filter { product in
            if let skinType = skinType, !product.skintype.contains(where: { $0.lowercased() == skinType }) {
                return false
            }
            
            if let primaryConcern = primaryConcern, !product.function.contains(where: { $0.lowercased().contains(primaryConcern) }) {
                return false
            }
            
            if !allergies.isEmpty, product.ingredients.contains(where: { ingredient in
                allergies.contains(ingredient.lowercased())
            }) {
                return false
            }
            
            if isPregnantOrBreastfeeding, product.ingredients.contains(where: { ingredient in
                unsafeIngredientsForPregnancy.contains(ingredient.lowercased())
            }) {
                return false
            }
            
            if user.age < 19, product.ingredients.contains(where: { ingredient in
                unsafeIngredientsForTeens.contains(ingredient.lowercased())
            }) {
                return false
            }
            
            return true
        }
        
        // Group products by category
        let categories = ["cleanser", "toner", "moisturizer", "sunscreen"]
        var categoryRecommendations: [ProductsData] = []
        
        // Process for individual categories
        for category in categories {
            let productsInCategory = filteredProducts.filter { $0.category.lowercased() == category }
            let randomProducts = productsInCategory.shuffled().prefix(2) // Take 2 random products
            categoryRecommendations.append(contentsOf: randomProducts)
        }
        
        // Handle serum and ampoule as a combined category
        let serumAndAmpoule = filteredProducts.filter {
            $0.category.lowercased() == "serum" || $0.category.lowercased() == "ampoule"
        }
        let randomSerumAndAmpoule = serumAndAmpoule.shuffled().prefix(2) // Take 2 random from combined serum and ampoule
        categoryRecommendations.append(contentsOf: randomSerumAndAmpoule)
        
        return categoryRecommendations
    }
}

    
    //struct ResultView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        let sampleAnswers: [String: String] = [
    //            "skinType": "Oily",
    //            "primaryConcern": "Acne",
    //            "allergies": "Fragrance, Parabens",
    //            "pregnantOrBreastfeeding": "No"
    //        ]
    //
    //        let sampleProducts: [Product] = [
    //            Product(
    //                id: "1",
    //                category: "Cleanser",
    //                brand: "SkinCare Co.",
    //                productName: "Gentle Cleanser",
    //                description: "A mild cleanser perfect for sensitive skin.",
    //                skinType: ["Dry", "Oily", "Sensitive"],
    //                ingredients: ["Water", "Glycerin", "Fragrance"],
    //                productFunction: ["Cleanser", "Hydration"],
    //                howToUse: ["Apply a small amount to damp skin.", "Rinse thoroughly with water."],
    //                link: "https://example.com/product1"
    //            ),
    //            Product(
    //                id: "2",
    //                category: "Treatment",
    //                brand: "AcneAway",
    //                productName: "Acne Treatment Gel",
    //                description: "An effective treatment for reducing acne.",
    //                skinType: ["Oily", "Combination"],
    //                ingredients: ["Salicylic Acid", "Niacinamide"],
    //                productFunction: ["Acne Treatment"],
    //                howToUse: ["Apply a small amount to damp skin.", "Rinse thoroughly with water."],
    //                link: "https://example.com/product2"
    //            )
    //        ]
    //
    //        let sampleQuestions: [Question] = [
    //            Question(
    //                id: 1,
    //                title: "What is your skin type?",
    //                description: "Choose the option that best describes your skin type.",
    //                options: ["Dry", "Oily", "Combination", "Sensitive"],
    //                isCheckbox: false,
    //                advice: [
    //                    "Oily": "Use lightweight, oil-free products to minimize shine.",
    //                    "Dry": "Use hydrating products to maintain moisture.",
    //                    "Combination": "Balance hydration and oil control for best results.",
    //                    "Sensitive": "Use gentle, fragrance-free products."
    //                ]
    //            )
    //        ]
    //
    //        return ResultView(
    //            answers: sampleAnswers,
    //            selectedImage: UIImage(named: "testphoto"), // Replace "sampleImage" with an actual image in your assets
    //            isAcneDetect: true
    //        )
    //    }
    //}
    

