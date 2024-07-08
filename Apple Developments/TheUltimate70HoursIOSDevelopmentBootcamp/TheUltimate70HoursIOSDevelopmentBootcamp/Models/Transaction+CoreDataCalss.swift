//
//  Transaction+CoreDataCalss.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 8/7/2024.
//

import CoreData
import Foundation

@objc(Transaction)
public class Transaction: NSManagedObject {
    override public func awakeFromInsert() {
        self.dateCreated = Date()
    }
}
