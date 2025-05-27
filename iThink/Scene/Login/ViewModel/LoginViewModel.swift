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

class LoginViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var isAnimating = false
    
    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Missing client ID")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let rootVC = UIApplication.shared.rootViewController else {
            print("No root view controller available")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { [weak self] result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                print("Missing ID token or access token")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In error: \(error.localizedDescription)")
                    return
                }

                DispatchQueue.main.async {
                    CoreDataManager.shared.createUser(id: user.userID ?? "", name: authResult?.user.displayName ?? "", email: authResult?.user.email ?? "", photoURL: authResult?.user.photoURL?.absoluteString ?? "")
                    self?.isSignedIn = true
                }
            }
        }
    }
}

