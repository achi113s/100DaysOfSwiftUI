//
//  DiceRoll.swift
//  DiceRolling
//
//  Created by Giorgio Latour on 6/21/23.
//

import Foundation

struct DiceRoll: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var dateRolled: Date = Date()
    var dieOneValue: Int
    var dieTwoValue: Int
    
    static let example = DiceRoll(dieOneValue: 4, dieTwoValue: 3)
}

@MainActor class DiceRolls: ObservableObject {
    @Published private(set) var rolls: [DiceRoll]
    
    var possibleSides: [Int] = [4, 6, 8, 10, 12, 20, 100]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("DiceRolls", conformingTo: .utf8PlainText)
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decodedData = try JSONDecoder().decode([DiceRoll].self, from: data)
            rolls = decodedData.sorted(by: { $0.dateRolled > $1.dateRolled })
        } catch {
            rolls = [DiceRoll]()
        }
    }
    
    func addRoll(_ roll: DiceRoll) {
        rolls.insert(roll, at: 0)
        saveRolls()
    }
    
    func removeRoll(_ roll: DiceRoll) {
        if let index = rolls.firstIndex(of: roll) {
            rolls.remove(at: index)
        }
        saveRolls()
    }
    
    func deleteAllRolls() {
        rolls.removeAll(keepingCapacity: true)
        saveRolls()
    }
    
    private func saveRolls() {
        do {
            let data = try JSONEncoder().encode(rolls)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Could not save dice rolls: \(error.localizedDescription)")
        }
    }
}
