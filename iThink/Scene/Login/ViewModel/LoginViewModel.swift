//
//  LoginViewModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

/// ViewModel responsible for managing the login logic using Google Sign-In and Firebase Authentication.
class LoginViewModel: ObservableObject {
    
    /// Indicates whether the user is successfully signed in.
    @Published var isSignedIn = false
    
    /// Controls the animation state in the login view.
    @Published var isAnimating = false
    
    /// Handles the Google Sign-In process and Firebase authentication.
    func signIn() {
        // Retrieve the Firebase client ID
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Missing client ID")
            return
        }
        
        // Configure Google Sign-In with the client ID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Ensure the app has a valid root view controller to present the Google Sign-In screen
        guard let rootVC = UIApplication.shared.rootViewController else {
            print("No root view controller available")
            return
        }
        
        // Start the Google Sign-In flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { [weak self] result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            // Extract the user and tokens from the sign-in result
            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                print("Missing ID token or access token")
                return
            }
            
            // Create a Firebase credential using the Google ID token and access token
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            // Sign in to Firebase using the Google credential
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In error: \(error.localizedDescription)")
                    return
                }
                
                // On successful login, store user info in Core Data and update UI state
                DispatchQueue.main.async {
                    CoreDataManager.shared.createUser(
                        id: user.userID ?? "",
                        name: authResult?.user.displayName ?? "",
                        email: authResult?.user.email ?? "",
                        photoURL: authResult?.user.photoURL?.absoluteString ?? ""
                    )
                    self?.isSignedIn = true
                }
            }
        }
    }
}
