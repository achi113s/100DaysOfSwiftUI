//
//  ContentView.swift
//  HabitTracker
//
//  Created by Giorgio Latour on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items, id: \.id) { item in
                    NavigationLink(destination: HabitDetailView(habits: habits, habit: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(Font.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text(item.streak > 1 ? "\(item.streak) 🔥" : "\(item.streak)")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("iStreak")
            .toolbar {
                Button {
                    showAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView(habits: habits)
            }
        }
        .tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
