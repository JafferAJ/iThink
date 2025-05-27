//
//  ViewExtensions.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        // Use keyWindow on iOS 15+; fallback for earlier
        return self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first(where: \.isKeyWindow)?.rootViewController
    }
}
