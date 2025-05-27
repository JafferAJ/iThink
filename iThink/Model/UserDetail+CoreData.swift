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



extension CoreDataManager {
    
    // MARK: - UserDetail CRUD

    /// Creates and saves a new UserDetail object into Core Data
    /// - Parameters:
    ///   - id: Unique identifier for the user
    ///   - name: User's display name
    ///   - email: User's email address
    ///   - photoURL: User's profile photo URL as a string
    func createUser(id: String, name: String, email: String, photoURL: String) {
        let user = UserDetail(context: context)
        user.id = id
        user.name = name
        user.email = email
        user.photoURL = photoURL
        saveContext()
    }

    /// Fetches all UserDetail entries from Core Data
    /// - Returns: An array of `UserDetail` objects or an empty array on failure
    func fetchUsers() -> [UserDetail] {
        let request: NSFetchRequest<UserDetail> = UserDetail.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }

    /// Deletes a specified UserDetail object from Core Data
    /// - Parameter user: The `UserDetail` object to delete
    func deleteUser(_ user: UserDetail) {
        context.delete(user)
        saveContext()
    }

}
