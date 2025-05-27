//
//  ViewExtensions.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import UIKit

// MARK: - UIApplication Extension

extension UIApplication {
    
    /// A computed property that retrieves the root view controller of the application's key window.
    ///
    /// - Returns: An optional `UIViewController` representing the root view controller of the current active (key) window.
    ///
    /// This is useful for presenting views (e.g., modals, alerts, or authentication screens) from anywhere in the app,
    /// especially when you're not directly within a view or view controller.
    ///
    var rootViewController: UIViewController? {
        return self.connectedScenes
            .compactMap { $0 as? UIWindowScene } // Extract UIWindowScene from connected scenes
            .first?
            .windows
            .first(where: \.isKeyWindow)? // Get the active window
            .rootViewController // Return its root view controller
    }
}
