import SwiftUI

struct OnboardingView: View {
    @State private var currentPage: Int = UserDefaults.standard.integer(forKey: "lastStep") == 0 ? 1 : UserDefaults.standard.integer(forKey: "lastStep")
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var age: Int = UserDefaults.standard.integer(forKey: "age") == 0 ? 18 : UserDefaults.standard.integer(forKey: "age")
    @State private var selectedGender: String = UserDefaults.standard.string(forKey: "gender") ?? ""
    @State private var isOnboardingComplete: Bool = UserDefaults.standard.bool(forKey: "isOnboardingComplete")

    
    let genders = ["Male", "Female"]

    var body: some View {
        if isOnboardingComplete {
            ContentView() // Navigasi langsung ke ContentView
        } else {
            VStack {
                ProgressView(currentPage: currentPage)
                    .padding()

                Spacer()

                TabView(selection: $currentPage) {
                    // Step 1: Input Username
                    VStack {
                        Text("Tell us your name")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
                        TextField("Enter username", text: $username)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .textInputAutocapitalization(.never)
                            .onChange(of: username) { _ in
                                saveProgress()
                            }
                        
                        Spacer()
                        
                        Button("Next") {
                            withAnimation {
                                currentPage = 2
                                saveProgress()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(username.isEmpty ? Color.gray : Color(red: 161/255, green: 170/255, blue: 123/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .disabled(username.isEmpty) // Disable button jika username kosong
                    }
                    .tag(1)
                    
                    // Step 2: Select Age
                    VStack {
                        Text("What's your age?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()

                        Picker("Select your age", selection: $age) {
                            ForEach(0..<100) { age in
                                Text("\(age)").tag(age)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 150)
                        .clipped()
                        .padding()
                        .onChange(of: age) { _ in
                            saveProgress()
                        }

                        Spacer()

                        Button("Next") {
                            withAnimation {
                                currentPage = 3
                                saveProgress()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    }
                    .tag(2)
                    
                    // Step 3: Select Gender
                    VStack {
                        Text("What's your gender?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()

                        HStack(spacing: 20) {
                            ForEach(genders, id: \.self) { gender in
                                Button(action: {
                                    selectedGender = gender
                                    saveProgress()
                                }) {
                                    VStack {
                                        Image(genderIcon(for: gender, isSelected: selectedGender == gender))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                            .background(selectedGender == gender ? genderColor(for: gender) : Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                        
                                        Text(gender)
                                            .font(.title2)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }

                        Spacer()

                        Button("Let's Get Started") {
                            // Simpan data dan tandai onboarding selesai
                            print("Username: \(username), Age: \(age), Gender: \(selectedGender)")
                            isOnboardingComplete = true
                            UserDefaults.standard.set(true, forKey: "isOnboardingComplete")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedGender.isEmpty ? Color.gray : Color(red: 161/255, green: 170/255, blue: 123/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .disabled(selectedGender.isEmpty) // Disable button jika gender belum dipilih
                    }
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
            }
        }
    }

    func saveProgress() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(selectedGender, forKey: "gender")
        UserDefaults.standard.set(currentPage, forKey: "lastStep")
    }

    func genderIcon(for gender: String, isSelected: Bool) -> String {
        switch gender {
        case "Male":
            return isSelected ? "male-selected" : "male-unselected"
        case "Female":
            return isSelected ? "female-selected" : "female-unselected"
        default:
            return "questionmark.circle"
        }
    }

    func genderColor(for gender: String) -> Color {
        switch gender {
        case "Male":
            return Color(red: 0.5882, green: 0.7529, blue: 1.0)
        case "Female":
            return Color(red: 0.9922, green: 0.6863, blue: 0.6863)
        default:
            return Color.gray.opacity(0.2)
        }
    }
}

struct ProgressView: View {
    let currentPage: Int

    var body: some View {
        HStack {
            ForEach(1...3, id: \.self) { step in
                Rectangle()
                    .fill(step <= currentPage ? Color(red: 161/255, green: 170/255, blue: 123/255) : Color.gray.opacity(0.3))
                    .frame(height: 5)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
