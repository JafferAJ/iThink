//
//  ImageCaptureView.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI

struct ImageCaptureView: View {
    @StateObject private var viewModel = ImageCaptureViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // MARK: - Top Navigation Bar with Back Button and Title
                HStack {
                    // Back button to dismiss the view
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
                            )
                    }
                    Spacer()
                    
                    // Screen title
                    Text("Upload Your Image")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                // MARK: - Glassmorphism Container for Image Preview or Placeholder
                ZStack {
                    // Rounded rectangle with ultra thin material for glass effect
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(radius: 10)
                    
                    VStack(spacing: 20) {
                        if let image = viewModel.selectedImage {
                            // Show selected or captured image
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 8)
                                .padding(.horizontal)
                        } else {
                            // Placeholder icon and instruction when no image is selected
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .foregroundColor(.white.opacity(0.5))
                                .padding()
                            
                            Text("Choose your photo source")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.subheadline)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                // MARK: - Action Buttons for Camera and Gallery
                VStack(spacing: 16) {
                    // Button to open the camera
                    Button(action: {
                        viewModel.showCamera = true
                    }) {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Capture from Camera")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }

                    // Button to open the photo gallery
                    Button(action: {
                        viewModel.showImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                            Text("Choose from Gallery")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                .font(.headline)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)

        // MARK: - Camera Sheet Presentation
        .sheet(isPresented: $viewModel.showCamera) {
            ImagePicker(sourceType: viewModel.sourceTypeCamera) { image in
                viewModel.selectedImage = image
            }
        }
        
        // MARK: - Gallery Sheet Presentation
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(sourceType: viewModel.sourceTypePhotoLibrary) { image in
                viewModel.selectedImage = image
            }
        }
    }
}

#Preview {
    ImageCaptureView()
}
