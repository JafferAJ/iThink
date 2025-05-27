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
