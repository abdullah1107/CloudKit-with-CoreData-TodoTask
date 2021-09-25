//
//  PersistanceStorage.swift
//  TaskList
//
//  Created by Muhammad Abdullah Al Mamun on 25/9/21.
//

import Foundation
import CoreData
import CloudKit
import UIKit



final class PersistentStorage{
    
    private init(){}
    static let shared = PersistentStorage()
    
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
       
        let container = NSPersistentCloudKitContainer(name: "TaskList")
       
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
   
    
    // MARK: - Core Data Saving support

    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    static var persistentContainer: NSPersistentContainer {
        return  PersistentStorage.shared.persistentContainer
    }
    
    static var viewContext: NSManagedObjectContext {
        let viewContext = persistentContainer.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        return viewContext
    }
    
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
    {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            
            return result

        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
    
   
    
}
