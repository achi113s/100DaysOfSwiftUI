//
//  Expenses.swift
//  iExpense
//
//  Created by Giorgio Latour on 4/17/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
