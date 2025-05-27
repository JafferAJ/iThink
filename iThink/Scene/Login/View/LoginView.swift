//
//  LoginView.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.purple.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // MARK: - Not Signed In UI
            VStack(spacing: 40) {
                // Profile Image / Default Icon
                Image("appLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 10)
                    .scaleEffect(viewModel.isAnimating ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isAnimating)
                
                VStack(spacing: 8) {
                    Text("Welcome to iThink")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Button(action: {
                    viewModel.signIn()
                }) {
                    HStack(spacing:20) {
                        Image("googleIcon") // Your Google logo asset
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text("Sign in with Google")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Capsule())
                    .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 4)
                    .overlay(
                        Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 55)
                .scaleEffect(viewModel.isAnimating ? 1.03 : 1)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isAnimating)
            }
            .padding()
            
            NavigationLink("", destination: DashboardView(), isActive: $viewModel.isSignedIn)

        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.isAnimating = true
        }
    }
}

#Preview {
    LoginView()
}
