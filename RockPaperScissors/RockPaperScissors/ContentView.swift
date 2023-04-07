//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Giorgio Latour on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice: String = "🪨"
    @State private var userShouldWinRound: Bool = false
    @State private var userScore: Int = 0
    @State private var showingScore: Bool = false
    @State private var questionNumber: Int = 1 {
        didSet {
            if questionNumber >= 11 {
                showingScore.toggle()
            }
        }
    }
    
    private let possibleMoves: [String] = ["🪨", "🧻", "✂️"]
    private var appChoiceBorderColor = Color("BaseFont")
    private let emojis: [String] = ["🪨", "🧻", "✂️"]
    private let pickToWin: [String:String] = ["🪨":"🧻", "🧻":"✂️", "✂️":"🪨"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color("BasePurple"), location: 0),
                .init(color: Color("BaseLilac"), location: 0.7),
                .init(color: Color("BaseLightPink"), location: 1)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("YOU NEED TO:")
                    .font(.custom("PermanentMarker-Regular", size: 30))
                    .foregroundColor(Color("BaseFont"))
                Text(userShouldWinRound ? "WIN" : "LOSE")
                    .font(.custom("PermanentMarker-Regular", size: 60))
                    .foregroundColor(Color("BaseFont"))
                
                Spacer()
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button {
                            buttonPressed(number)
                        } label: {
                            EmojiLabel(emoji: emojis[number])
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(appChoice == emojis[number] ? appChoiceBorderColor : Color(.clear), lineWidth: 5)
                            
                        )
                    }
                }
                Spacer()
            }
        }
        .alert("Game Over!", isPresented: $showingScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func buttonPressed(_ number: Int) {
        if userShouldWinRound {
            if emojis[number] == pickToWin[appChoice] {
                userScore += 1
            } else {
                userScore -= 1
            }
        } else {
            if emojis[number] != pickToWin[appChoice] {
                userScore += 1
            } else {
                userScore -= 1
            }
        }
        userShouldWinRound.toggle()
        appChoice = emojis.randomElement()!
        questionNumber += 1
    }
    
    func restartGame() {
        userShouldWinRound.toggle()
        appChoice = emojis.randomElement()!
        questionNumber = 1
        userScore = 0
    }
}

struct EmojiLabel: View {
    var emoji: String
    var body: some View {
        Text(emoji).font(.system(size: 125))
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
