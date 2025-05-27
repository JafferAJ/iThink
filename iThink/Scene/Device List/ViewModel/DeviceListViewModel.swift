//
//  DeviceListViewModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation

class DeviceListViewModel: ObservableObject {
    @Published var items: [DeviceModel] = []
    @Published var notificationsEnabled = UserDefaults.standard.value(forKey: "notificationsEnabled") as? Bool ?? false
    
    // MARK: - Load devices from local Core Data storage
    func loadItems() {
        items = CoreDataManager.shared.fetchDevices()
    }

    // MARK: - Fetch data from API and save new devices into Core Data
    func importFromAPI() {
        fetchItems { apiItems in
            for item in apiItems {
                // Encode dictionary to Base64 string for storage
                if let dataDict = item.data {
                    CoreDataManager.shared.createDevice(
                        id: item.id,
                        name: item.name,
                        data: try? JSONEncoder().encode(dataDict).base64EncodedString()
                    )
                }
            }
            // Refresh the local items list after import
            self.loadItems()
        }
    }

    // MARK: - Delete a device item from Core Data and send notification if enabled
    func delete(_ item: DeviceModel) {
        if notificationsEnabled {
            NotificationManager.shared.sendDeletionNotification(itemName: item.name)
        }
        CoreDataManager.shared.deleteDevice(item)
        loadItems() // Refresh items list after deletion
    }

    // MARK: - Update the name of a device and save changes to Core Data
    func update(_ item: DeviceModel, newName: String) {
        // Prevent empty or whitespace-only names
        guard !newName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        item.name = newName
        CoreDataManager.shared.saveContext()
        loadItems()
    }
    
    // MARK: - Fetch device data from remote API
    func fetchItems(completion: @escaping ([DeviceResponseModel]) -> Void) {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            return
        }

        // Create and start URLSession data task
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle networking error here if needed
                return
            }

            guard let data = data else {
                // Handle missing data here if needed
                return
            }

            do {
                // Decode JSON response into an array of DeviceResponseModel
                let items = try JSONDecoder().decode([DeviceResponseModel].self, from: data)
                DispatchQueue.main.async {
                    completion(items)
                }
            } catch {
                print("JSON decode error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
