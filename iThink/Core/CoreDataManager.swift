//
//  Persistence.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        container = NSPersistentContainer(name: "iThink")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - UserDetail CRUD

    func createUser(id: String, name: String, email: String, photoURL: String) {
        let user = UserDetail(context: context)
        user.id = id
        user.name = name
        user.email = email
        user.photoURL = photoURL
        saveContext()
    }

    func fetchUsers() -> [UserDetail] {
        let request: NSFetchRequest<UserDetail> = UserDetail.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }

    func deleteUser(_ user: UserDetail) {
        context.delete(user)
        saveContext()
    }

    // MARK: - DeviceModel CRUD

    func createDevice(id: String, name: String, data: String?) {
        let device = DeviceModel(context: context)
        device.id = id
        device.name = name
        device.data = data
        saveContext()
    }

    func fetchDevices() -> [DeviceModel] {
        let request: NSFetchRequest<DeviceModel> = DeviceModel.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch devices: \(error)")
            return []
        }
    }

    func deleteDevice(_ device: DeviceModel) {
        context.delete(device)
        saveContext()
    }
}
