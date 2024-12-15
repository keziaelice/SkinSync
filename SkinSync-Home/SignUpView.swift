import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var showPopup = false
    @State private var navigateToVerification = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 246/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Image("logo app")
                        .resizable()
                        .frame(width: 330, height: 120)
                    
                    Text("Create Your Account")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)
                        .padding(.top, -15)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(22)
                        .font(.system(size: 15))
                        .padding(.horizontal, 30)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .frame(height: 35)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(22)
                        .font(.system(size: 15))
                        .padding(.horizontal, 30)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .frame(height: 35)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        } else {
                            SecureField("Password", text: $password)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(22)
                    .padding(.horizontal, 30)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .frame(height: 35)
                    
                    HStack {
                        if isConfirmPasswordVisible {
                            TextField("Confirm Password", text: $confirmPassword)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        } else {
                            SecureField("Confirm Password", text: $confirmPassword)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                        Button(action: {
                            isConfirmPasswordVisible.toggle()
                        }) {
                            Image(systemName: isConfirmPasswordVisible ? "eye.fill" : "eye.slash.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(22)
                    .padding(.horizontal, 30)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .frame(height: 35)
                    
                    Button(action: {
                        print("Sign Up button tapped")
                        showPopup = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            navigateToVerification = true
                        }
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .fontWeight(.bold)
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                    }
                    .padding(.horizontal, 30)
                    
                    Text("Or Sign Up With")
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .padding(.top, 30)
                    
                    Button(action: {
                        print("Google login tapped")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 50, height: 50)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            Image("logo google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }.padding(.top, 20)
                }
                .padding()
                
                if showPopup {
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 300, height: 200)
                                .shadow(radius: 10)
                            
                            VStack(spacing: 20) {
                                ZStack {
                                    Circle()
                                        .stroke(Color(red: 115/255, green: 121/255, blue: 100/255), lineWidth: 2)
                                        .frame(width: 100, height: 70)
                                    Image(systemName: "checkmark")
                                        .font(.title)
                                        .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                                }
                                Text("Verified!")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 115/255, green: 121/255, blue: 100/255))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.top, 250)
                        .offset(x:0, y: -300)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToVerification) {
                VerificationView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    SignUpView()
}
