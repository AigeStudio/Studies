//
//  ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/18.
//

import SwiftUI

enum SheetAction: Identifiable {
    case add
    case edit(BudgetCategory)
    var id: Int {
        switch self {
        case .add:
            return 1
        case .edit:
            return 2
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    @State private var sheetAction: SheetAction?
    var total: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            result + budgetCategory.total
        }
    }

    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }

    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Total Budget - ")
                    Text(total as NSNumber, formatter: NumberFormatter.currency).fontWeight(.bold)
                }
                BudgetListView(budgetCategoryResult: budgetCategoryResults, onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView(budgetCategory: nil)
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
    }
}
