import SwiftUI

struct ProfileView: View {
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("age") private var storedAge: String = ""
    
    @State private var isDarkMode: Bool = false
    @State private var showAlert: Bool = false
    @State private var showSaveNotification: Bool = false
    @State private var username: String = ""
    @State private var age: String = ""
    
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 250/255, blue: 246/255)
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
                
                // About Us and Contact Us
                Section(header: Text("Information")) {
                    NavigationLink(destination: AboutUsView()) {
                        Text("About Us")
                    }
                    NavigationLink(destination: ContactUsView()) {
                        Text("Contact Us")
                    }
                }
                
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
            .navigationTitle("Profile")
            .onAppear {
                loadData() // Memuat data saat halaman dibuka
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveData()
                    }
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
        username = ""
        age = ""
        storedUsername = ""
        storedAge = ""
        isDarkMode = false
        toggleAppearance(darkMode: false)
        showAlert = true
    }
    
    private func saveData() {
        guard !username.isEmpty, !age.isEmpty else {
            print("Name or Age is empty.")
            return
        }
        storedUsername = username
        storedAge = age
        print("Data saved: Name: \(storedUsername), Age: \(storedAge)")
        showSaveNotification = true // Tampilkan notifikasi
    }
    
    private func loadData() {
        username = storedUsername
        age = storedAge
        print("Data loaded: Name: \(username), Age: \(age)")
    }
}

struct AboutUsView: View {
    var body: some View {
        VStack {

            Text("""
SkinSync is an innovative application that helps users detect their skin type using cutting-edge camera technology and machine learning algorithms. 

In addition, it offers personalized quizzes to assist users in scheduling and maintaining skincare routines tailored to their specific skin type. Whether you are a skincare enthusiast or a beginner, SkinSync aims to empower users to take control of their skincare journey with ease and confidence.

Join us in revolutionizing the way we care for our skin!
""")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .navigationTitle("About Us")
    }
}

struct ContactUsView: View {
    var body: some View {
        VStack {

            Text("""
We would love to hear from you!

If you have any questions, feedback, or concerns, feel free to reach out to us via email:

skinskinsyncsync@gmail.com

Follow us on social media to stay updated with our latest features and offers.
""")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .navigationTitle("Contact Us")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
