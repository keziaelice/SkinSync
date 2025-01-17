import SwiftUI

struct PhotoResultView: View {
    @Binding var selectedImage: UIImage?
    @State private var isCameraPresented = false
    @State private var isConfirm = false
    @State private var acneResults: String = ""
    @State private var isAcneDetect: Bool = false
    
    var body: some View {
        VStack {
            Text("Photo Result")
                .fontWeight(.bold)
                .foregroundColor(Color.colorText)
                .padding(.bottom, 20)
                .font(.system(size: 24))
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .cornerRadius(40)
            }
            
            HStack(spacing: 20) {
                Button("Retake") {
                    isCameraPresented = true
                }
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding()
                .background(Color(red: 225/255, green: 223/255, blue: 223/255))
                .cornerRadius(8)
                
                Button("Confirm") {
                    uploadImageToRoboflow(image: selectedImage)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding()
                .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                .cornerRadius(8)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .center)
            
            // Only navigate when we have a result
            NavigationLink("", destination: QuestionView(selectedImage: selectedImage, isAcneDetect: $isAcneDetect), isActive: $isConfirm)
                .hidden()
        }
        .padding()
        .sheet(isPresented: $isCameraPresented) {
            ImagePickerView(image: $selectedImage, isPresented: $isCameraPresented)
        }
    }
    
    func uploadImageToRoboflow(image: UIImage?) {
        guard let image = image, let imageData = image.jpegData(compressionQuality: 0.5) else {
            self.acneResults = "Error: Invalid image."
            return
        }
        
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        
        let url = URL(string: "https://detect.roboflow.com/skin-detection-uvj1f/3?api_key=DlYxKA34LweMBdX9nDrl&name=uploaded_image.jpg")!
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = base64String.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                if let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let predictions = responseDict["predictions"] as? [[String: Any]] {
                    
                    var acneDetected = false
                    
                    for prediction in predictions {
                        if let label = prediction["class"] as? String,
                           let confidence = prediction["confidence"] as? Double,
                           label == "Acne" && confidence > 0.5 {
                            acneDetected = true
                            break
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.isAcneDetect = acneDetected
                        self.acneResults = acneDetected ? "Acne detected." : "No acne detected."
                        self.isConfirm = true  // Only navigate after we have a result
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.acneResults = "No predictions found or invalid response."
                        self.isAcneDetect = false
                        self.isConfirm = true
                    }
                }
            } catch {
                print("Error parsing response: \(error)")
                DispatchQueue.main.async {
                    self.acneResults = "Error parsing prediction response."
                    self.isAcneDetect = false
                    self.isConfirm = true
                }
            }
        }.resume()
    }
}

//struct PhotoResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoResultView(selectedImage: .constant(UIImage(named: "testphoto") ?? UIImage()))
//    }
//}
