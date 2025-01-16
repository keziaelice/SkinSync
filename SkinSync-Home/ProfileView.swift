import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [UserModel]
    
    @State private var isDarkMode: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSaveNotification: Bool = false
    @State private var username: String = ""
    @State private var age: String = ""
    
    var body: some View {
        ZStack {
            (isDarkMode ? Color("backgroundColorPage") : Color("backgroundColorPage"))
                            .ignoresSafeArea()
            NavigationView {
                Form {
                    // Dark Mode Toggle
                    Section(header: Text("Appearance")) {
                        Toggle(isOn: $isDarkMode) {
                            Text("Dark Mode")
                        }
                        .onChange(of: isDarkMode) { value in
                            toggleAppearance(darkMode: value)
                        }
                    }
                    
                    // Name and Age Input
                    Section(header: Text("Personal Information")) {
                        TextField("Name", text: $username)
                            .textInputAutocapitalization(.words)
                        TextField("Age", text: $age)
                            .keyboardType(.numberPad)
                    }
                    
//                    // About Us and Contact Us
//                    Section(header: Text("Information")) {
//                        NavigationLink(destination: AboutUsView()) {
//                            Text("About Us")
//                        }
//                        NavigationLink(destination: ContactUsView()) {
//                            Text("Contact Us")
//                        }
//                    }
                    
                    // Reset Data
                    Section {
                        Button(action: {
                            resetData()
                        }) {
                            Text("Reset Data")
                                .foregroundColor(.red)
                        }
                    }
                }
                .scrollContentBackground(.hidden) // Hides the default form background
                .background(Color.backgroundColorPage) // Custom background
                .listRowBackground(Color.backgroundColorPage) // Matches section background
                .navigationTitle("Profile")
                .toolbarBackground(Color.backgroundColorElement, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            
                .onAppear {
                    loadData()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            saveData()
                        }
                        .foregroundColor(Color.backgroundColorPage)
                    }
                }
                .alert("Data Saved", isPresented: $showSaveNotification) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your data has been successfully saved.")
                }
                .alert("Data Reset", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your data has been reset.")
                }
            }
            .background(Color.backgroundColorPage)
        }
    }
    
    private func toggleAppearance(darkMode: Bool) {
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) {
            window.overrideUserInterfaceStyle = darkMode ? .dark : .light
        }
    }
    
    private func resetData() {
        // Delete all existing users
        for user in users {
            modelContext.delete(user)
        }
        
        try? modelContext.save()
        
        username = ""
        age = ""
        isDarkMode = false
        toggleAppearance(darkMode: false)
        showAlert = true
        
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "age")
        UserDefaults.standard.removeObject(forKey: "currentPageOnboarding")
        UserDefaults.standard.removeObject(forKey: "isOnboardingComplete")

    }
    
    private func saveData() {
        guard !username.isEmpty, !age.isEmpty,
              let ageInt = Int(age) else {
            print("Invalid input: Name or Age is empty or Age is not a number")
            return
        }
        
        // Update existing user or create new one
        if let existingUser = users.first {
            // Update existing user
            existingUser.username = username
            existingUser.age = ageInt
        } else {
            // Create new user
            let newUser = UserModel(username: username, age: ageInt)
            modelContext.insert(newUser)
        }
        
        // Save changes
        do {
            try modelContext.save()
            showSaveNotification = true
            print("Data saved successfully: Name: \(username), Age: \(age)")
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    private func loadData() {
        if let user = users.first {
            username = user.username
            age = String(user.age)
            print("Data loaded: Name: \(username), Age: \(age)")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
