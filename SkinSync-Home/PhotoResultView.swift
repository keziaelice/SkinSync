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
                .foregroundColor(Color(red: 25/255, green: 48/255, blue: 115/255))
                .padding(.bottom, 20)
                .font(.system(size: 24))
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .cornerRadius(40)
            }
            
//            Text(acneResults)
//                .font(.headline)
//                .padding()
            
            HStack(spacing: 20) {
                Button("Retake") {
                    isCameraPresented = true // Open camera for retake
                }
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding()
                .background(Color(red: 225/255, green: 223/255, blue: 223/255))
                .cornerRadius(8)
                
                Button("Confirm") {
                    uploadImageToRoboflow(image: selectedImage) // Trigger acne detection
                    isConfirm = true
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding()
                .background(Color(red: 161/255, green: 170/255, blue: 123/255))
                .cornerRadius(8)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .center)
            
            // Navigation to Question
            NavigationLink("", destination: QuestionView(selectedImage: selectedImage, isAcneDetect: isAcneDetect), isActive: $isConfirm)
                .hidden()
        }
        .onAppear {
            print("isAcneDetect:", isAcneDetect)
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
                    var resultsText = "Detection Results:\n"
                    
                    for prediction in predictions {
                        if let label = prediction["class"] as? String,
                           let confidence = prediction["confidence"] as? Double,
                           label == "Acne" && confidence > 0.5 {
                            acneDetected = true
                            resultsText += """
                            Label: \(label)
                            Confidence: \(String(format: "%.2f", confidence * 100))%
                            Bounding Box: \(prediction["x"] ?? ""), \(prediction["y"] ?? "")
                            Width: \(prediction["width"] ?? ""), Height: \(prediction["height"] ?? "")
                            \n\n
                            """
                            
                            resultsText = "Acne detected."
                            isAcneDetect = true
                            
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.acneResults = acneDetected ? resultsText : "No acne detected."
                        isAcneDetect = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.acneResults = "No predictions found or invalid response."
                    }
                }
            } catch {
                print("Error parsing response: \(error)")
                DispatchQueue.main.async {
                    self.acneResults = "Error parsing prediction response."
                }
            }
        }.resume()
    }
}

struct PhotoResultView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoResultView(selectedImage: .constant(UIImage(named: "testphoto") ?? UIImage()))
    }
}
