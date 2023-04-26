//
//  Activity.swift
//  HabitTracker
//
//  Created by Giorgio Latour on 4/25/23.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    let name: String
    let description: String
    var streak: Int = 0
}
