//
//  Transaction+CoreDataProperties.swift
//  MoneyTracker
//
//  Created by Bruce Roettgers on 10.01.18.
//  Copyright © 2018 bcye. All rights reserved.
//
//

import Foundation
import CoreData

//auto created for CORE DATA
extension Transaction {

    //sorts items by date
    public class func fetchRequest() -> NSFetchRequest<Transaction> {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }

    @NSManaged public var amount: Float
    @NSManaged public var isPositive: Bool
    @NSManaged public var text: String?
    @NSManaged public var date: NSDate?

}
