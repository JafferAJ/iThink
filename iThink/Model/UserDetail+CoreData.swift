//
//  UserDetail+CoreData.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import CoreData

// MARK: UserDetail Class
/// The `UserDetail` class is an NSManagedObject representing a user in Core Data.
@objc(UserDetail)
public class UserDetail: NSManagedObject {
}

// MARK: DeviceModel Extension
extension UserDetail {
    
    // MARK: Fetch Request
    /// Creates a fetch request for `UserDetail`.
    /// - Returns: A configured `NSFetchRequest<UserDetail>` for fetching user records.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetail> {
        return NSFetchRequest<UserDetail>(entityName: "UserDetail")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var photoURL: String?
}


