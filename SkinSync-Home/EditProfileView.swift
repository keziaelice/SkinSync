import SwiftUI

struct EditProfileView: View {
    @State private var username: String = "bobby.123"
    @State private var firstName: String = "Bobby"
    @State private var lastName: String = "Adrian"
    @State private var phoneNumber: String = "08 **** ****"
    @State private var email: String = "bobby@gmail.com"
    @State private var dateOfBirth: String = "21/8/2003"

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // List Options
                VStack(spacing: 20) {
                    // Username
                    RoundedInputField(title: "Username", value: $username)

                    // First Name
                    RoundedInputField(title: "First Name", value: $firstName)

                    // Last Name
                    RoundedInputField(title: "Last Name", value: $lastName)

                    // Phone Number
                    RoundedInputField(title: "Phone Number", value: $phoneNumber)

                    // Email
                    RoundedInputField(title: "Email", value: $email)

                    // Date of Birth
                    RoundedInputField(title: "Date of Birth", value: $dateOfBirth)
                }
                .padding()

                // Save Button (diletakkan di dalam VStack)
                Button(action: {
                    print("Profile updated: \(username), \(firstName), \(lastName)")
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#a1aa7b")) // Hijau tua
                        .foregroundColor(Color(hex: "#ffffff")) // Putih
                        .cornerRadius(12)
                }
                .padding()
            }
            .background(Color(hex: "#fffaf6")) // Cream
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Custom Rounded Input Field
struct RoundedInputField: View {
    var title: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color(hex: "#737964")) // Hijau tua banget
            TextField("", text: $value)
                .padding()
                .background(Color(hex: "#eceade")) // Hijau muda
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "#737964"), lineWidth: 1) // Hijau tua banget
                )
        }
    }
}

// Extension for Hex Color Support
extension Color {
    init(Hex: String) {
        let scanner = Scanner(string: Hex)
        _ = scanner.scanString("#")
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r = Double((hexNumber & 0xff0000) >> 16) / 255
        let g = Double((hexNumber & 0x00ff00) >> 8) / 255
        let b = Double(hexNumber & 0x0000ff) / 255

        self.init(red: r, green: g, blue: b)
    }
}

// Preview
struct EditProfileView_Preview: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
