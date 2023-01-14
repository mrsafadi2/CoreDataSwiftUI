//
//  CoreDataManager.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container:NSPersistentContainer
    let context:NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "DB")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error:\(error.localizedDescription)")
             }
        }
        context = container.viewContext
     }
    
    func save(complation: @escaping (Error?) -> ()  = { _ in }){
        let context = container.viewContext
        if context.hasChanges {
            do {
               try  container.viewContext.save()
                complation(nil)
                print("Save Done Successfully")
            }catch let error {
                complation(error)
            }
        }
    }
    
    func delete(_  object : NSManagedObject , complation: @escaping (Error?) -> ()  = { _ in } ) {
        let context = container.viewContext
        context.delete(object)
        save(complation: complation)
    }
    
  
    
}
