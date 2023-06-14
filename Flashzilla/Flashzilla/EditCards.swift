//
//  EditCards.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/13/23.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    
    enum Field {
        case prompt
        case answer
    }
    
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            List {
                Section("Add New Card") {
                    TextField("Prompt", text: $newPrompt)
                        .focused($focusedField, equals: .prompt)
                        .submitLabel(.next)
                    TextField("Answer", text: $newAnswer)
                        .focused($focusedField, equals: .answer)
                        .submitLabel(.done)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func addCard() {
        focusedField = nil
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        
        newPrompt = ""
        newAnswer = ""
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.setValue(data, forKey: "Cards")
        }
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
