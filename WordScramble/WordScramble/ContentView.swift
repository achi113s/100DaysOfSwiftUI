//
//  ContentView.swift
//  WordScramble
//
//  Created by Giorgio Latour on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Score: \(score)") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button {
                    withAnimation {
                        usedWords.removeAll(keepingCapacity: true)
                    }
                    startGame()
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word Used Already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word Not Recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Word Too Short", message: "Your answer must be longer than three letters!")
            return
        }
        
        guard isNotRootWord(word: answer) else {
            wordError(title: "Word Cannot Be Root Word", message: "Your answer can't be the root word!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        let pointsToAdd = calculatePoints(with: answer)
        score += pointsToAdd
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count > 3
    }
    
    func isNotRootWord(word: String) -> Bool {
        return !word.elementsEqual(rootWord)
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculatePoints(with answer: String) -> Int {
        let lengthPoints = Int(pow(Double(answer.count), 3))
        let basePoints = 50
        
        let totalPoints = lengthPoints + basePoints
        
        return totalPoints
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
