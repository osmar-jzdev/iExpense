//
//  HomeView.swift
//  iExpense
//
//  Created by Osmar Juarez on 26/04/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showingAddExpense = false
    @State private var expenses = ExpensesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+ Add Expense", action: {
                        showingAddExpense = true
                    })
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            ExpenseSheetView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
}
