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
        VStack {
            Spacer()
            Form {
                Text("\(habit.name)")
                    .font(.largeTitle)
                Section("Description") {
                    Text("\(habit.name)")
                }
                Divider()
                Section("Streak") {
                    let ending: String = habit.streak > 1 || habit.streak == 0 ? " times!" : " time!"
                    let streakDescription: String = "You've completed this \(habit.streak)\(ending)"
                    Text(streakDescription)
                }
            }.scrollContentBackground(.hidden)
                .scrollDisabled(true)
            Button {
                incrementStreak()
            } label: {
                Text("Complete!")
                    .font(.largeTitle)
            }
            .buttonStyle(.bordered)
            Spacer()
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
