//
//  NotificationManager.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }

    func sendDeletionNotification(itemName: String) {
        guard UserDefaults.standard.bool(forKey: "notificationsEnabled") else { return }

        DispatchQueue.main.async {
            let content = UNMutableNotificationContent()
            content.title = "Item Deleted"
            content.body = "Deleted: \(itemName)"
            content.sound = .default

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Notification error: \(error.localizedDescription)")
                }
            }
        }
    }

    
}
