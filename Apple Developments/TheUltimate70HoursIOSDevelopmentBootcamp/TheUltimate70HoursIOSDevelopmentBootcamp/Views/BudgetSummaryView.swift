//
//  BudgetSummaryView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 8/7/2024.
//

import SwiftUI

struct BudgetSummaryView: View {
    @ObservedObject var budgetCategory: BudgetCategory
    var body: some View {
        Text("\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))")
            .frame(maxWidth: .infinity)
            .fontWeight(.bold)
            .foregroundColor(budgetCategory.overSpent ? .red : .green)
    }
}
