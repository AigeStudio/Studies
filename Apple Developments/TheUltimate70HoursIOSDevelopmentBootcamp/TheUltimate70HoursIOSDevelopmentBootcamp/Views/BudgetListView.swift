//
//  BudgetListView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 7/7/2024.
//

import SwiftUI

struct BudgetListView: View {
    let budgetCategoryResult: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    var body: some View {
        List {
            if !budgetCategoryResult.isEmpty {
                ForEach(budgetCategoryResult) { budgetCategory in
                    HStack {
                        Text(budgetCategory.title ?? "")
                        Spacer()
                        VStack {
                            Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.map { budgetCategoryResult[$0] }.forEach(onDeleteBudgetCategory)
                })
            } else {
                Text("No budget categories exists.")
            }
        }
    }
}
