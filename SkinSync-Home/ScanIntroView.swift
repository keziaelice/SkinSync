//
//  ScanIntroView.swift
//  SkinSync-Home
//
//  Created by MacBook Pro on 09/01/25.
//

import SwiftUI

struct ScanIntroView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage? = nil
    @State private var isPhotoResultPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to the Face Analysis")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.colorText)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Image("Image") // Placeholder image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                Text("""
                    Let’s start analyzing your face with our face analyzer. This will help you know what your skin needs!
                    
                    First, let’s take a front-side picture of yourself. Make sure your face is bare, well-lit, and front-facing for the best results.
                    """)
                    .font(.body)
                    .foregroundColor(Color.colorText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Button(action: {
                    self.isImagePickerPresented.toggle()
                }) {
                    Text("Take A Photo")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.backgroundColorElement)
                        .cornerRadius(8)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePickerView(image: $selectedImage, isPresented: $isImagePickerPresented)
                }
                
                // NavigationLink to go to PhotoResultView when selectedImage is not nil
                NavigationLink(destination: PhotoResultView(selectedImage: $selectedImage), isActive: $isPhotoResultPresented) {
                    EmptyView() // Empty view acts as the trigger for navigation
                }
                .hidden()
            }
            .padding()
            .onChange(of: selectedImage) { newImage in
                // Trigger navigation when an image is selected
                if newImage != nil {
                    isPhotoResultPresented = true
                }
            }
        }
    }
}

struct ScanIntroView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScanIntroView()
        }
    }
}
