//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Giorgio Latour on 4/25/23.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var habits: Habits
    
    @State private var habitName: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    TextField("e.g. Feed the Fish", text: $habitName)
                }
                Section("Description") {
                    TextField("e.g. Feed 1 cube of shrimp per day", text: $description)
                }
            }
            .navigationTitle("Add Habit")
            .toolbar {
                Button {
                    let habit = Habit(name: habitName, description: description)
                    habits.items.append(habit)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        .tint(.black)
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
