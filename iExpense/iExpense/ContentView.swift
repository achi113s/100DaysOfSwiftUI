//
//  ContentView.swift
//  iExpense
//
//  Created by Giorgio Latour on 4/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense: Bool = false
    let cur = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: cur))
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(item.name) \(item.amount) \(cur)")
                        .accessibilityHint(item.type)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
