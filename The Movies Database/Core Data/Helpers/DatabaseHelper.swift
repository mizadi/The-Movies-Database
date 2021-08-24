//
//  DatabaseHelper.swift
//  The Movies Database
//
//  Created by Adi Mizrahi on 12/07/2021.
//

import Foundation
import CoreData
class DatabaseHelper {
    
    static var shared = DatabaseHelper()
    
    var container: NSPersistentContainer!
    
    var movies = [MovieProtocol]()
    
    init() {
        container = NSPersistentContainer(name: "The_Movies_Database")
        container.loadPersistentStores { storeDescription, error in
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
  
    
    
    
   
}
