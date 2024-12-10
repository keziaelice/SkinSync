import SwiftUI

struct OnboardingView: View {
    @State private var currentPage: Int = 1
    @State private var username: String = ""
    @State private var age: Int = 18
    @State private var selectedGender: String = ""
    
    let genders = ["Male", "Female", "Non-Binary"]

    var body: some View {
        VStack {
            // Timeline / Progress Bar
            ProgressView(currentPage: currentPage)
                .padding()

            Spacer()
            
            // Page Content
            TabView(selection: $currentPage) {
                // Page 1: Username
                VStack {
                    Text("Hai, kami BASE! Kalau kamu?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    
                    TextField("Masukkan Username", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Button("Lanjut") {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                .tag(1)
                
                // Page 2: Age
                VStack {
                    Text("Berapa umur kamu?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()

                    Picker("Pilih Umur", selection: $age) {
                        ForEach(0..<100) { age in
                            Text("\(age)").tag(age)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .clipped()
                    .padding()

                    Spacer()

                    Button("Lanjut") {
                        withAnimation {
                            currentPage = 3
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                .tag(2)
                
                // Page 3: Gender
                VStack {
                    Text("Pilih Gender Kamu")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()

                    HStack(spacing: 20) {
                        ForEach(genders, id: \.self) { gender in
                            Button(action: {
                                selectedGender = gender
                            }) {
                                VStack {
                                    Image(systemName: genderSymbol(for: gender))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding()
                                        .background(selectedGender == gender ? Color.blue : Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                    
                                    Text(gender)
                                        .font(.caption)
                                }
                            }
                        }
                    }

                    Spacer()

                    Button("Let's Get Started") {
                        print("Username: \(username), Age: \(age), Gender: \(selectedGender)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
        }
    }

    func genderSymbol(for gender: String) -> String {
        switch gender {
        case "Male":
            return "person.fill"
        case "Female":
            return "person.fill.badge.plus"
        case "Non-Binary":
            return "questionmark.circle"
        default:
            return "person"
        }
    }
}

struct ProgressView: View {
    let currentPage: Int

    var body: some View {
        HStack {
            ForEach(1...3, id: \.self) { step in
                Rectangle()
                    .fill(step <= currentPage ? Color.red : Color.gray.opacity(0.3))
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

