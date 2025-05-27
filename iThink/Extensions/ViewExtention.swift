//
//  ViewExtension.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import SwiftUI

// MARK: - Color Extension for Hex Initialization

extension Color {
    
    /// Initializes a SwiftUI `Color` using a hexadecimal string.
    ///
    /// - Parameter hex: A hex string representing the color, with or without a "#" prefix.
    /// Converts the hex string into RGB components and initializes the corresponding color.
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: .whitespacesAndNewlines))
        
        // Skip the "#" prefix if present
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        // Extract red, green, and blue components from the hex value
        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0

        // Initialize the SwiftUI Color
        self.init(red: r, green: g, blue: b)
    }
}
