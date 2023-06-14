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
    
    @EnvironmentObject var cards: Cards
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
                    ForEach(Array(cards.cards.enumerated()), id: \.element) { item in
                        VStack(alignment: .leading) {
                            Text(item.element.prompt)
                                .font(.headline)
                            Text(item.element.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: cards.deleteCard)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
        }
    }
    
    func addCard() {
        focusedField = nil
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.addCard(card)
        
        newPrompt = ""
        newAnswer = ""
    }
    
    func done() {
        dismiss()
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
