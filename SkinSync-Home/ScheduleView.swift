import SwiftUI
struct ScheduleView: View {
    @State private var selectedDateObject = Date() // Tanggal terpilih
    @State private var schedules: [Schedule] = [
        Schedule(title: "Schedule 1", description: "Menggunakan basic skincare", time: Date()),
        Schedule(title: "Schedule 2", description: "Menggunakan sunscreen", time: Date()),
        Schedule(title: "Schedule 3", description: "Menggunakan facial wash", time: Date()),
        Schedule(title: "Schedule 4", description: "Makan siang sehat", time: Date()),
        Schedule(title: "Schedule 5", description: "Olahraga pagi", time: Date()),
        Schedule(title: "Schedule 6", description: "Istirahat siang", time: Date())
    ] // Menyimpan data schedule
    
    @State private var calendarWidth: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        // Action for back button
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Schedule")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color(red: 161 / 255, green: 170 / 255, blue: 123 / 255))
                
                // Content divided into two equal parts
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        // Calendar Section (Upper 50%)
                        VStack {
                            Text("\(formattedDate(selectedDateObject))")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                            DatePicker(
                                "Select Date",
                                selection: $selectedDateObject,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .frame(height: geometry.size.height / 2 - 25) // Menyesuaikan tinggi kalender
                            .background(
                                Color.white
                                    .cornerRadius(8)
                                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            )
                            .padding()
                            .accentColor(Color(red: 115/255, green: 121/255, blue: 100/255)) // Warna lingkaran hijau tua
                        }
                        .background(Color(red: 161 / 255, green: 170 / 255, blue: 123 / 255))
                        
                        // Schedule Section (Lower 50%)
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(schedules.indices, id: \.self) { index in
                                    NavigationLink(destination: ScheduleEditorView(schedule: $schedules[index])) {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(schedules[index].title)
                                                        .font(.headline)
                                                        .foregroundColor(.black)
                                                    Text(schedules[index].description)
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                        .lineLimit(2)
                                                }
                                                Spacer()
                                                Text("\(formattedTime(schedules[index].time))")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            .padding()
                                        }
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .background(Color(red: 236 / 255, green: 234 / 255, blue: 222 / 255))
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
    
    // Function to format date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy" // Format hari, tanggal, bulan, dan tahun
        return formatter.string(from: date)
    }
    
    // Function to format time
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Format jam
        return formatter.string(from: date)
    }
}
// Model untuk Schedule
struct Schedule {
    var title: String
    var description: String
    var time: Date
}
// View untuk mengedit jadwal
struct ScheduleEditorView: View {
    @Binding var schedule: Schedule // Binding ke schedule yang ada di halaman utama
    
    @State private var isSaved = false // Untuk melacak status penyimpanan
    
    var body: some View {
        VStack {
            // Title
            TextField("Enter Title", text: $schedule.title)
                .font(.title)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            // Description
            TextEditor(text: $schedule.description)
                .font(.body)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(height: 150)
                .padding(.horizontal)
            
            // Time Picker
            DatePicker(
                "Select Time",
                selection: $schedule.time,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
            .padding()
            
            // Save Button
            Button(action: {
                isSaved = true // Tandai bahwa perubahan telah disimpan
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 161 / 255, green: 170 / 255, blue: 123 / 255))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(isSaved ? "Edited" : "Edit Schedule") // Ubah judul setelah disimpan
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

