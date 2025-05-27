//
//  APIServiceViewModel.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import Foundation

class APIServiceViewModel: ObservableObject {
    @Published var items: [DeviceModel] = []
    @Published var notificationsEnabled = UserDefaults.standard.value(forKey: "notificationsEnabled") as? Bool ?? false


    func loadItems() {
        items = CoreDataManager.shared.fetchDevices()
    }

    func importFromAPI() {
        fetchItems { apiItems in
            for item in apiItems {
                if let dataDict = item.data {
                    CoreDataManager.shared.createDevice(id: item.id, name: item.name, data: try? JSONEncoder().encode(dataDict).base64EncodedString())
                }
            }
            self.loadItems()
        }
    }

    func delete(_ item: DeviceModel) {
        if notificationsEnabled {
            NotificationManager.shared.sendDeletionNotification(itemName: item.name)
        }
        CoreDataManager.shared.deleteDevice(item)
        loadItems()
    }

    func update(_ item: DeviceModel, newName: String) {
        guard !newName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        item.name = newName
        CoreDataManager.shared.saveContext()
        loadItems()
    }
    
    func fetchItems(completion: @escaping ([DeviceResponseModel]) -> Void) {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }

            guard let data = data else {
                return
            }

            do {
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


