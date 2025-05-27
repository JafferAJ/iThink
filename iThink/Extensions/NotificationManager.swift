//
//  NotificationManager.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import UserNotifications

// MARK: - UserNotifications
/// A singleton class responsible for managing local notifications.
class NotificationManager {
    
    /// Shared instance of `NotificationManager`.
    static let shared = NotificationManager()

    /// Requests user authorization for displaying notifications (alerts, badges, and sounds).
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }

    /// Sends a local notification indicating that an item has been deleted.
    /// - Parameter itemName: The name of the item that was deleted.
    func sendDeletionNotification(itemName: String) {
        // Check user preference before sending notification
        guard UserDefaults.standard.bool(forKey: "notificationsEnabled") else { return }

        DispatchQueue.main.async {
            let content = UNMutableNotificationContent()
            content.title = "Item Deleted"
            content.body = "Deleted: \(itemName)"
            content.sound = .default

            // Create and add the notification request
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: nil // Deliver immediately
            )

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Notification error: \(error.localizedDescription)")
                }
            }
        }
    }
}
