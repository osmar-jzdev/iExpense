//
//  Expenseitem.swift
//  iExpense
//
//  Created by Osmar Juarez on 14/06/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
