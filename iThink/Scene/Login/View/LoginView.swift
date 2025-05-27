//
//  LoginView.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore

/// A view that presents a login screen with Google Sign-In using a gradient background and animated UI elements.
struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.purple.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // MARK: - Login UI
            VStack(spacing: 40) {
                
                // Animated Logo Image
                Image("appLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 10)
                    .scaleEffect(viewModel.isAnimating ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: viewModel.isAnimating)
                
                // Welcome Texts
                VStack(spacing: 8) {
                    Text("Welcome to iThink")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                // Google Sign-In Button
                Button(action: {
                    viewModel.signIn()
                }) {
                    HStack(spacing: 20) {
                        Image("googleIcon") // Google logo image asset
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
                
                // Navigation to Dashboard without sign in to google
                Button(action: {
                    viewModel.isSignedIn = true
                }) {
                    Text("Direct Login")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.init(top: 5, leading: 25, bottom: 5, trailing: 25))
                        .background(Color.white.opacity(0.18))
                        .clipShape(Capsule())
                        .shadow(radius: 4)
                }
                .padding(.top, 40)

            }
            .padding()
            
            // Navigation to Dashboard when signed in
            NavigationLink(
                "",
                destination: DashboardView(),
                isActive: $viewModel.isSignedIn
            )
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.isAnimating = true // Start the logo animation
        }
    }
}

#Preview {
    LoginView()
}
