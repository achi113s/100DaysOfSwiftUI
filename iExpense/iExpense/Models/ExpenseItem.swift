//
//  Expense.swift
//  iExpense
//
//  Created by Giorgio Latour on 4/17/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
