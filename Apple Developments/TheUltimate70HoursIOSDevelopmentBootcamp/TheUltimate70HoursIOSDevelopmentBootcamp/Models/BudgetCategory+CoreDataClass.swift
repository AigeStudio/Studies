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
        dateCreated = Date()
    }

    var overSpent: Bool {
        remainingBudgetTotal < 0
    }

    var transactionsTotal: Double {
        transactionsArray.reduce(0) { result, transaction in
            result + transaction.total
        }
    }

    var remainingBudgetTotal: Double {
        total - transactionsTotal
    }

    private var transactionsArray: [Transaction] {
        guard let transactions = transactions else { return [] }
        let allTransaction = (transactions.allObjects as? [Transaction]) ?? []
        return allTransaction.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }

    static func transactionByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category = %@", budgetCategory)
        return request
    }
}
