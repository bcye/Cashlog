//
//  CoreDataStack.swift
//  MoneyTracker
//
//  Created by Bruce Roettgers on 09.01.18.
//  Copyright © 2018 bcye. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TransactionList")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                //TODO: Find way to alert the user from here
                print(error)
            }
        }
        return container
    }()
    
}

//extension to saveChanges in managedObjectCOntext
extension NSManagedObjectContext {
    func saveChanges(viewController: UIViewController) {
        if self.hasChanges {
            do {
                try save()
            } catch {
                error.alert(with: viewController, error: .saveFailed)
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
