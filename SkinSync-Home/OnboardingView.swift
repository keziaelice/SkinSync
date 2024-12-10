import SwiftUI

struct OnboardingView: View {
    @State private var currentPage: Int = 1
    @State private var username: String = ""
    @State private var age: Int = 18
    @State private var selectedGender: String = ""
    
    let genders = ["Male", "Female"]

    var body: some View {
        VStack {
            ProgressView(currentPage: currentPage)
                .padding()

            Spacer()
             
            TabView(selection: $currentPage) {
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
                    
                    Spacer()
                    
                    Button("Next") {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                .tag(1)
                
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

                    Spacer()

                    Button("Next") {
                        withAnimation {
                            currentPage = 3
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
                
                VStack {
                    Text("What's your gender?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()

                    HStack(spacing: 20) {
                        ForEach(genders, id: \.self) { gender in
                            Button(action: {
                                selectedGender = gender
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
                        print("Username: \(username), Age: \(age), Gender: \(selectedGender)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 161/255, green: 170/255, blue: 123/255))
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
