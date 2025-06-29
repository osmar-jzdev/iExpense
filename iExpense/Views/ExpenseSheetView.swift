//
//  IncomeSheetView.swift
//  iExpense
//
//  Created by Osmar Juarez on 03/05/25.
//
import SwiftUI

struct ExpenseSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var amountString: String = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var expenses = ExpensesViewModel()

    let types = ["Food","Entreteinment", "Utilities", "Personal", "Business", "Others"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amountString)
                    .keyboardType(.decimalPad)
                    .onTapGesture {
                        if amountString == "US$0.00" || amountString == "0" {
                            amountString = ""
                        }
                    }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let cleaned = amountString
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .replacingOccurrences(of: ",", with: ".")

                        guard !cleaned.isEmpty else {
                            alertMessage = "Please, add an amount."
                            showAlert = true
                            return
                        }

                        guard let amount = Double(cleaned), amount > 0 else {
                            alertMessage = "Please, add a valid amount. At least more than 0 dollars."
                            showAlert = true
                            return
                        }

                        guard !name.isEmpty else {
                            alertMessage = "Please, add a name for the expense."
                            showAlert = true
                            return
                        }
                    
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                }
            }
            .alert("Error to save expense", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(alertMessage)
                    }
        }
    }
}

#Preview {
    ExpenseSheetView()
}
