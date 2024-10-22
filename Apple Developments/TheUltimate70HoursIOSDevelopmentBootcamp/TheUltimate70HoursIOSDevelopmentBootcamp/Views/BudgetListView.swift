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
    let onEditBudgetCategory: (BudgetCategory) -> Void

    var body: some View {
        List {
            if !budgetCategoryResult.isEmpty {
                ForEach(budgetCategoryResult) { budgetCategory in
                    NavigationLink(destination: BudgetDetailView(budgetCategory: budgetCategory), label: {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack(alignment: .trailing, spacing: 10) {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                                Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .fontWeight(.bold)
                                    .foregroundColor(budgetCategory.overSpent ? .red : .green)
                            }
                        }
                        .onLongPressGesture {
                            onEditBudgetCategory(budgetCategory)
                        }
                        .contentShape(Rectangle())
                    })
                }.onDelete(perform: { indexSet in
                    indexSet.map { budgetCategoryResult[$0] }.forEach(onDeleteBudgetCategory)
                })
            } else {
                Text("No budget categories exists.")
            }
        }
        .listStyle(.plain)
    }
}
