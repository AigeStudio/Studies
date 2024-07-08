//
//  BudgetCategory+CoreDataClass.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 5/7/2024.
//

import CoreData
import Foundation

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    override public func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
