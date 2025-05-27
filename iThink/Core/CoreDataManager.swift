//
//  Persistence.swift
//  iThink
//
//  Created by Abdul Jaafar on 26/05/25.
//

import CoreData

/// A singleton class that manages Core Data stack and provides CRUD operations for UserDetail and DeviceModel entities.
class CoreDataManager {
    
    /// Shared instance for global access to CoreDataManager
    static let shared = CoreDataManager()
    
    /// The NSPersistentContainer that encapsulates the Core Data stack
    let container: NSPersistentContainer

    /// The main context used for all Core Data operations
    var context: NSManagedObjectContext {
        container.viewContext
    }

    /// Initializes the Core Data stack with the persistent container named "iThink"
    private init() {
        container = NSPersistentContainer(name: "iThink")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    /// Saves changes in the current context if there are any.
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed saving context: \(error.localizedDescription)")
            }
        }
    }
}
