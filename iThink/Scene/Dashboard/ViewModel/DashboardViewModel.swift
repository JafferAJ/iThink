//
//  DashboardViewModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class DashboardViewModel: ObservableObject {
    @Published var isToViewReport = false
    @Published var isToImageCapture = false
    @Published var notificationsEnabled = UserDefaults.standard.value(forKey: "notificationsEnabled") as? Bool ?? false
    @Published var gotoAPIService = false
    @Published var isToLogin = false
    @Published var userDetails: UserDetail?
    

    func getUserDetails() {
        if let user = CoreDataManager.shared.fetchUsers().first {
            userDetails = user
        } else {
            let authUser = Auth.auth().currentUser
            CoreDataManager.shared.createUser(id: authUser?.uid ?? "", name: authUser?.displayName ?? "", email: authUser?.email ?? "", photoURL: authUser?.photoURL?.absoluteString ?? "")
            if let user = CoreDataManager.shared.fetchUsers().first {
                userDetails = user
            }
        }
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            if let user = userDetails {
                CoreDataManager.shared.deleteUser(user)
            }
            isToLogin = true
        } catch {
            print("Sign-out failed: \(error.localizedDescription)")
        }
    }
    
    

    
}
