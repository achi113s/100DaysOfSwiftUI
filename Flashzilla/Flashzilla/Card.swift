//
//  Card.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/13/23.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

@MainActor class Cards: ObservableObject {
    @Published private(set) var cards: [Card]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    init() {
        // JSON File in Documents directory
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            cards = decoded
        } catch {
            cards = [Card]()
        }
    }
    
    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        saveData()
    }
    
    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    func reloadCards() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            cards = decoded
        } catch {
            cards = [Card]()
        }
    }
    
    func removeCard(at index: Int, reinsert: Bool) {
        guard index >= 0 else { return }
        
        if reinsert {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cards.remove(at: index)
        }
    }
    
    private func saveData() {
        // JSON File in Documents Directory
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Could not save Cards: \(error.localizedDescription)")
        }
    }
}
