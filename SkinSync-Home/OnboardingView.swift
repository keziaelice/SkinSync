import SwiftUI
import SwiftData

// MARK: - Helper Functions for UserDefaults
struct OnboardingHelper {
    static func saveToUserDefaults(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }

    static func retrieveFromUserDefaults<T>(key: String, defaultValue: T) -> T {
        return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
}

// MARK: - Pre_OnboardingView
struct Pre_OnboardingView: View {
    @State private var currentPage = OnboardingHelper.retrieveFromUserDefaults(key: "currentPage", defaultValue: 0)
    private let totalPages = 3
    @State private var isPreOnboardingComplete = OnboardingHelper.retrieveFromUserDefaults(key: "isPreOnboardingComplete", defaultValue: false)
    private let currentPageKey = "currentPage"

    var body: some View {
        if isPreOnboardingComplete {
            OnboardingView()
        } else {
            NavigationStack {
                VStack {
                    GeometryReader { geometry in
                        HStack(spacing: 0) {
                            page1(geometry: geometry)
                            page2(geometry: geometry)
                            page3(geometry: geometry)
                        }
                        .offset(x: -CGFloat(currentPage) * geometry.size.width)
                        .animation(.easeInOut, value: currentPage)

                    }
                    .frame(height: 600)

                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }

    // MARK: - Pages
    private func page1(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            Image("logo app")
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)
                .padding(.top, -50)
            Text("Your journey to healthier skin starts here")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.colorText)
                .padding(.horizontal, 24)
                .padding(.top, -180)

            Spacer()

            Button(action: { goToNextPage(page: 1) }) {
                buttonLabel("Next")
            }
            .padding(.top, 40)
        }
        .frame(width: geometry.size.width)
    }

    private func page2(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            Image("PreOnboarding1")
                .resizable()
                .scaledToFit()
                .frame(width: 450, height: 450)
            Text("Analyze Your Skin")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(Color.colorText)
                .padding(.top, -160)
            Text("A deeper look at your skin’s health")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.colorText)
                .padding(.horizontal, 24)
                .padding(.top, -70)

            Spacer()

            Button(action: { goToNextPage(page: 2) }) {
                buttonLabel("Next")
            }
            .padding(.top, 130)
        }
        .frame(width: geometry.size.width)
    }

    private func page3(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            Image("PreOnboarding2")
                .resizable()
                .scaledToFit()
                .frame(width: 450, height: 450)
            Text("Start!")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(Color.colorText)
                .padding(.top, -160)
            Text("Join us and achieve your skin care goals")
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.colorText)
                .padding(.horizontal, 24)
                .padding(.top, -70)

            Spacer()

            Button(action: completePreOnboarding) {
                buttonLabel("Start")
            }
            .padding(.top, 130)
        }
        .frame(width: geometry.size.width)
    }

    private func goToNextPage(page: Int) {
        withAnimation {
            currentPage = page
            OnboardingHelper.saveToUserDefaults(key: currentPageKey, value: currentPage)
        }
    }

    private func completePreOnboarding() {
        OnboardingHelper.saveToUserDefaults(key: currentPageKey, value: totalPages)
        OnboardingHelper.saveToUserDefaults(key: "isPreOnboardingComplete", value: true)
        isPreOnboardingComplete = true
    }

    private func buttonLabel(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 161/255, green: 170/255, blue: 123/255))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

// MARK: - OnboardingView with Custom UI
struct OnboardingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [UserModel]
    
    @State private var username: String = OnboardingHelper.retrieveFromUserDefaults(key: "username", defaultValue: "")
    @State private var age: Int = OnboardingHelper.retrieveFromUserDefaults(key: "age", defaultValue: 18)
    @State private var isOnboardingComplete: Bool = OnboardingHelper.retrieveFromUserDefaults(key: "isOnboardingComplete", defaultValue: false)
    @State private var currentPage: Int = OnboardingHelper.retrieveFromUserDefaults(key: "currentPageOnboarding", defaultValue: 0)

    
    private let totalPages = 2
    
    var body: some View {
        if isOnboardingComplete {
            ContentView()
        } else {
            NavigationStack {
                ZStack {
                    Color.backgroundColorPage
                        .ignoresSafeArea()
                    VStack {
                        ProgressBar(currentPage: currentPage, totalPages: totalPages)
                        
                        Spacer()
                        
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                onboardingStep1(geometry: geometry)
                                onboardingStep2(geometry: geometry)
//                                onboardingStep3(geometry: geometry)
                            }
                            .offset(x: -CGFloat(currentPage) * geometry.size.width)
                            .animation(.easeInOut, value: currentPage)
                        }
                        
                        Spacer()
                    }
                }
                .navigationBarBackButtonHidden(true)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
        }
    }
    
    // MARK: - Onboarding Steps
    func onboardingStep1(geometry: GeometryProxy) -> some View {
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
                .onChange(of: username) { _ in saveProgress() }
            
            Spacer()
            
            Button(action: { goToNextPage(1) }) {
                buttonLabel("Next", isEnabled: !username.isEmpty)
            }
            .disabled(username.isEmpty)
        }
        .frame(width: geometry.size.width)
    }
    
    func onboardingStep2(geometry: GeometryProxy) -> some View {
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
            .onChange(of: age) { _ in saveProgress() }
            
            Spacer()
            Button(action: completeOnboarding) {
                buttonLabel("Let's Get Started", isEnabled: true)
            }
        }
        .frame(width: geometry.size.width)
    }
    
    func addUserData(_username: String, _age: Int) {
        let newUser = UserModel(username: _username, age: _age)
        modelContext.insert(newUser)
    }
    
    func ProgressBar(currentPage: Int, totalPages: Int) -> some View {
        ProgressView(value: Double(currentPage), total: Double(totalPages))
            .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 161/255, green: 170/255, blue: 123/255)))
            .frame(height: 10)
            .padding()
    }
    
    func buttonLabel(_ text: String, isEnabled: Bool) -> some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding()
            .background(isEnabled ? Color(red: 161/255, green: 170/255, blue: 123/255) : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
    
    func saveProgress() {
        OnboardingHelper.saveToUserDefaults(key: "username", value: username)
        OnboardingHelper.saveToUserDefaults(key: "age", value: age)
        OnboardingHelper.saveToUserDefaults(key: "currentPageOnboarding", value: currentPage)
    }
    
    func goToNextPage(_ page: Int) {
        hideKeyboard()
        withAnimation { currentPage = page }
    }
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    func completeOnboarding() {
        OnboardingHelper.saveToUserDefaults(key: "isOnboardingComplete", value: true)
        OnboardingHelper.saveToUserDefaults(key: "username", value: username)
        OnboardingHelper.saveToUserDefaults(key: "age", value: age)
        isOnboardingComplete = true
        UserDefaults.standard.set(true, forKey: "isOnboardingComplete")
        
        addUserData(_username: username, _age: age)
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

#Preview {
    Pre_OnboardingView()
}
