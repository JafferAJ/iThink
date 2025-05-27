//
//  iThinkApp.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

// MARK: - Main Entry Point
@main
struct iThinkApp: App {
    // Use AppDelegate for Firebase setup and notifications
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // Conditional navigation based on authentication state
                if Auth.auth().currentUser != nil && CoreDataManager.shared.fetchUsers().first != nil{
                    DashboardView()
                } else {
                    LoginView()
                }
            }
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
        }
    }
}

// MARK: - AppDelegate for App Lifecycle, Firebase & Notifications
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // Called when app finishes launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()

        // Request notification permissions from user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Permission error: \(error.localizedDescription)")
            }
            print("Permission granted: \(granted)")
        }

        // Set notification center delegate to handle foreground notifications
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // Called when app enters background
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did enter background")
    }

    // Called when app becomes active again
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Did become active")
    }

    // Show notifications as banner and sound even when app is in foreground
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }

    // Handle Google Sign-In URL callback
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
