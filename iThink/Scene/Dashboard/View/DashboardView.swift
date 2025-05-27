//
//  DashboardView.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.8), Color.purple.opacity(0.9)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    // MARK: - Profile Header
                    VStack {
                        let imageURL = viewModel.userDetails?.photoURL
                        if imageURL != nil && imageURL != "" {
                            AsyncImage(url: URL(string: imageURL ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 8)
                        }
                        
                        Text(viewModel.userDetails?.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Welcome to iThink App")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // MARK: - Action Buttons
                    VStack(spacing: 20) {
                        IThinkButton(title: "Device List", systemImage: "server.rack") {
                            withAnimation { viewModel.gotoDeviceList = true }
                        }
                        IThinkButton(title: "View Report", systemImage: "doc.richtext") {
                            withAnimation { viewModel.isToViewReport = true }
                        }
                        IThinkButton(title: "Capture or select image", systemImage: "camera") {
                            withAnimation { viewModel.isToImageCapture = true }
                        }
                        
                        // Notifications toggle row
                        HStack {
                            Image(systemName: "bell.badge")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            Text("Enable Notifications")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 170)
                            
                            Toggle("", isOn: $viewModel.notificationsEnabled)
                                .onChange(of: viewModel.notificationsEnabled) { newValue in
                                    UserDefaults.standard.setValue(newValue, forKey: "notificationsEnabled")
                                }
                        }
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // MARK: - Sign Out Button
                    Button(action: {
                        viewModel.signOutUser()
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.red.opacity(0.8))
                            .clipShape(Capsule())
                            .shadow(radius: 4)
                    }
                    .padding(.top, 40)
                }
                .padding()
            }
            
            // NavigationLinks driven by state variables
            NavigationLink("", destination: ReportView(), isActive: $viewModel.isToViewReport)
            NavigationLink("", destination: DeviceListView(), isActive: $viewModel.gotoDeviceList)
            NavigationLink("", destination: ImageCaptureView(), isActive: $viewModel.isToImageCapture)
            NavigationLink("", destination: LoginView(), isActive: $viewModel.isToLogin)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getUserDetails()
        }
    }
}

#Preview {
    DashboardView()
}
