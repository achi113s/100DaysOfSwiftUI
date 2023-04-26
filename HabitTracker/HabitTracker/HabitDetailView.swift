//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Giorgio Latour on 4/25/23.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var habits: Habits
    @State var habit: Habit
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Description: \(habit.description)")
                    .font(.title.bold())
                Spacer()
                Text(habit.streak > 1 ? "\(habit.streak) 🔥" : "\(habit.streak)")
                    .font(.largeTitle)
                
                Button {
                    incrementStreak()
                } label: {
                    Text("Complete!")
                        .bold()
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .navigationTitle(habit.name)
        }
        .tint(.black)
    }
    
    func incrementStreak() {
        if let habitIndex = habits.items.firstIndex(of: habit) {
            var newHabit = habit
            newHabit.streak += 1
            habits.items[habitIndex] = newHabit
            habit = newHabit
        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static let habits = Habits()
    static let habit = Habit(name: "Feed the Fish", description: "Feed the fish once per day")
    
    static var previews: some View {
        HabitDetailView(habits: habits, habit: habit)
    }
}
