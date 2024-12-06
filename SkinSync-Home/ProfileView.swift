import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Section
                ZStack {
                    Color(hex: "#a1aa7b") // Hijau tua
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 180)
                    
                    VStack(alignment: .leading) {
                        // Judul Profile Setting
                        Text("Profile Setting")
                            .font(.title3)
                            .foregroundColor(Color(hex: "#283316"))
                            .padding()
                            .fontWeight(.heavy)
                            .padding(.leading, 20)
                        
                        HStack(alignment: .center) {
                            // Foto Profil
                            Image(systemName: "person.crop.circle.fill") // Placeholder
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color(hex: "#eceade")) // Hijau muda
                                .background(Color(hex: "#283316")) // Putih
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color(hex: "#283316"), lineWidth: 3)
                                )
                                .padding(.leading, 25) // Geser foto profil ke kanan
                            
                            // Teks di sebelah Foto Profil
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Hello")
                                    .font(.subheadline)
                                    .foregroundColor(Color(hex: "#283316"))
                                
                                Text("Bobby Adrian")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: "#283316"))
                            }
                            .padding(.leading, 10) // Geser teks ke kanan
                            
                            Spacer()
                            
                            // Tombol Edit dengan NavigationLink
                            NavigationLink(destination: EditProfileView()) {
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color(hex: "#283316"))
                            }
                            .padding(.trailing, 40) // Geser tombol edit ke kanan
                        }
                    }
                }
                .padding(.bottom, 20) // Menambahkan padding antara header dan tombol
                
                // "Check Your Progress" Button
                Button(action: {
                    // Aksi untuk progress
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Check your")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color.white)
                            
                            Text("progress")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        Image(systemName: "clock.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing, 20)
                            .frame(width: 70, height: 70) // Ukuran ikon
                            .foregroundColor(Color.white)
                    }
                    .padding() // Menambahkan ruang di dalam tombol
                    .padding(.vertical, 10)
                    .background(Color.yellow) // Warna latar belakang tombol
                    .cornerRadius(15) // Membuat sudut tombol membulat
                    .shadow(radius: 2) // Menambahkan bayangan untuk tombol
                }
                .padding(.horizontal) // Memberikan padding luar tombol
                .padding(.bottom, 20)
                
                // List Options
                List {
                    NavigationLink(destination: Text("Saved")) {
                        Text("Saved")
                            .font(.headline) // Bold
                            .foregroundColor(Color(hex: "#181717")) // Hitam
                            .padding(.vertical, 8) // Mengurangi padding vertikal
                    }
                    
                    NavigationLink(destination: Text("Setting")) {
                        Text("Setting")
                            .font(.headline) // Bold
                            .foregroundColor(Color(hex: "#181717")) // Hitam
                            .padding(.vertical, 8) // Mengurangi padding vertikal
                    }
                    
                    NavigationLink(destination: Text("Support")) {
                        Text("Support")
                            .font(.headline) // Bold
                            .foregroundColor(Color(hex: "#181717")) // Hitam
                            .padding(.vertical, 8) // Mengurangi padding vertikal
                    }
                    
                    NavigationLink(destination: Text("About Us")) {
                        Text("About us")
                            .font(.headline) // Bold
                            .foregroundColor(.black) // Hitam
                            .padding(.vertical, 8) // Mengurangi padding vertikal
                    }
                    
                    Button(action: {
                        // Aksi untuk logout
                    }) {
                        Text("Logout")
                            .font(.headline) // Bold
                            .foregroundColor(.red) // Warna merah untuk Logout
                            .padding(.vertical, 8) // Mengurangi padding vertikal
                    }
                }
                .listStyle(PlainListStyle())
                .clipShape(RoundedRectangle(cornerRadius: 15)) // Membuat list lebih rounded
                .padding(.horizontal)
            }
            .background(Color(hex: "#fffaf6")) // Cream
        }
    }
}

// Extension untuk Color
extension Color {
init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    var hexNumber: UInt64 = 0
    scanner.scanHexInt64(&hexNumber)
    
    let r = Double((hexNumber & 0xff0000) >> 16) / 255
    let g = Double((hexNumber & 0x00ff00) >> 8) / 255
    let b = Double(hexNumber & 0x0000ff) / 255
    
    self.init(red: r, green: g, blue: b)
}
}

struct ProfileView_Previews: PreviewProvider {
static var previews: some View {
    ProfileView()
}
}
