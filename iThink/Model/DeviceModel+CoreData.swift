//
//  DeviceModel+CoreData.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import CoreData

// MARK: DeviceModel Class
/// The `DeviceModel` class is an NSManagedObject representing a user in Core Data.
@objc(DeviceModel)
public class DeviceModel: NSManagedObject {
}

// MARK: DeviceModel Extension
extension DeviceModel {
    
    // MARK: Fetch Request
    /// Creates a fetch request for `DeviceModel`.
    /// - Returns: A configured `NSFetchRequest<DeviceModel>` for fetching user records.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceModel> {
        return NSFetchRequest<DeviceModel>(entityName: "DeviceModel")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var data: String?
}

extension CoreDataManager {
    
    // MARK: - DeviceModel CRUD

    /// Creates and saves a new DeviceModel object into Core Data
    /// - Parameters:
    ///   - id: Unique identifier for the device
    ///   - name: Device name
    ///   - data: Optional encoded JSON string containing device metadata
    func createDevice(id: String, name: String, data: String?) {
        let device = DeviceModel(context: context)
        device.id = id
        device.name = name
        device.data = data
        saveContext()
    }

    /// Fetches all DeviceModel entries from Core Data
    /// - Returns: An array of `DeviceModel` objects or an empty array on failure
    func fetchDevices() -> [DeviceModel] {
        let request: NSFetchRequest<DeviceModel> = DeviceModel.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch devices: \(error)")
            return []
        }
    }

    /// Deletes a specified DeviceModel object from Core Data
    /// - Parameter device: The `DeviceModel` object to delete
    func deleteDevice(_ device: DeviceModel) {
        context.delete(device)
        saveContext()
    }

}

