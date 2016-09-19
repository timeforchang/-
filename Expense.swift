//
//  Expense.swift
//  $
//
//  Created by Andrew on 6/15/16.
//
//

import Foundation
import CoreData

@objc(Expense)
class Expense: NSManagedObject
{
    // Insert code here to add functionality to your managed object subclass
    @NSManaged var cost: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var type: String?
}