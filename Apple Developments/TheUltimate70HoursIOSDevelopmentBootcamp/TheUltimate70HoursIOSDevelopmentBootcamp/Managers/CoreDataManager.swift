//
//  CoreDataManager.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 5/7/2024.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to initialize Core Data stack \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
