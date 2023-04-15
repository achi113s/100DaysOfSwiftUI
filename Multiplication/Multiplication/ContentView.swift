//
//  ContentView.swift
//  Multiplication
//
//  Created by Giorgio Latour on 4/13/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isGameActive: Bool = false
    @State private var minTimesTable: Int = 0
    @State private var maxTimesTable: Int = 10
    @State private var numberOfQuestions: Int = 0
    
    @State private var currentQuestion: Int = 1
    @State private var numberCorrect: Int = 0
    @State private var answer: String = ""
   
    @State private var showingResult: Bool = false
    @State private var resultTitle: String = ""
    @State private var resultMessage: String = ""
    
    @FocusState private var answerIsFocused: Bool
    
    @State private var player: AVAudioPlayer!
    
    var score: Double {
        return Double(numberCorrect)/Double(numberOfQuestions+2) * 100.0
    }
    
    @State var questions: [Question] = [Question]()
    
    let cloudTextShadowRadius: CGFloat = 2.0
    
    let DeepKoamaru: Color = Color("#30336b")
    let GreenDarnerTail: Color = Color("#74b9ff")
    
    var body: some View {
        if isGameActive == false {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color("Sky"), location: 0),
                    .init(color: Color("SkyLow"), location: 0.9)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("MATH IS FUN")
                        .font(.custom("RubikBubbles-Regular", size: 45))
                        .foregroundColor(.white)
                        .shadow(radius: cloudTextShadowRadius)
                    HStack {
                        Text("HOW MANY QUESTIONS?")
                            .font(.custom("RubikBubbles-Regular", size: 20))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Picker("Min Times Table", selection: $numberOfQuestions) {
                            ForEach(2..<21) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    HStack {
                        Text("WHICH TIMES TABLES?")
                            .font(.custom("RubikBubbles-Regular", size: 20))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Picker("Min Times Table", selection: $minTimesTable) {
                            ForEach(2..<13) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.wheel)
                        Text("TO")
                            .font(.custom("RubikBubbles-Regular", size: 20))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Picker("Max Times Table", selection: $maxTimesTable) {
                            ForEach(2..<13) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    
                    Spacer()
                    
                    Button {
                        isGameActive.toggle()
                        
                        generateQuestions()
                        
                        print(questions)
                    } label: {
                        Text("GO!")
                            .font(.custom("RubikBubbles-Regular", size: 70))
                            .frame(width: 200)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .shadow(radius: cloudTextShadowRadius)
                    .tint(.cyan)
                }
                .padding()
            }
        } else {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color("Sky"), location: 0),
                    .init(color: Color("SkyLow"), location: 0.9)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                VStack {
                    HStack{
                        Text("Question: \(currentQuestion)/\(numberOfQuestions+2)")
                            .font(.custom("RubikBubbles-Regular", size: 25))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Spacer()
                        Text("SCORE: \(score.formatted())")
                            .font(.custom("RubikBubbles-Regular", size: 25))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Text("WHAT IS")
                            .font(.custom("RubikBubbles-Regular", size: 60))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Spacer()
//                        Text("11 x 11")
                        Text("\(questions[currentQuestion-1].text)")
                            .font(.custom("RubikBubbles-Regular", size: 60))
                            .foregroundColor(.white)
                            .shadow(radius: cloudTextShadowRadius)
                        Spacer()
                        HStack {
                            Text("ANSWER:")
                                .font(.custom("RubikBubbles-Regular", size: 20))
                                .foregroundColor(.white)
                                .shadow(radius: cloudTextShadowRadius)
                            TextField("Enter your answer", text: $answer)
                                .keyboardType(.numberPad)
                                .frame(height: 25)
                                .focused($answerIsFocused)
                        }
                        Spacer()
                        Button {
                            checkAnswer(answer)
                            showingResult.toggle()
                            answerIsFocused = false
                        } label: {
                            Text("CHECK")
                                .font(.custom("RubikBubbles-Regular", size: 25))
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .shadow(radius: cloudTextShadowRadius)
                        .tint(.cyan)
                        .alert(resultTitle, isPresented: $showingResult) {
                            Button {
                                answer = ""
                                if currentQuestion < numberOfQuestions + 2 {
                                    currentQuestion += 1
                                } else {
                                    numberCorrect = 0
                                    currentQuestion = 1
                                    isGameActive.toggle()
                                }
                            } label: {
                                if currentQuestion < numberOfQuestions + 2 {
                                    Text("Next Question")
                                } else {
                                    Text("Reset Game")
                                }
                            }
                        } message: {
                            Text(resultMessage)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    func generateQuestions() {
        for _ in 0..<numberOfQuestions + 2 {
            let minNum = minTimesTable + 2
            let maxNum = maxTimesTable + 2
            
            let first = Int.random(in: minNum...maxNum)
            let second = Int.random(in: minNum...maxNum)
            
            let question = Question(text: "\(first) × \(second)", answer: first*second)
            questions.append(question)
        }
    }
    
    func checkAnswer(_ answer: String) {
        if let safeAnswer = Int(answer) {
            if safeAnswer == questions[currentQuestion-1].answer {
                resultTitle = "CORRECT"
                resultMessage = "You got it right!"
                numberCorrect += 1
                playChime(correct: true)
            } else {
                resultTitle = "WRONG"
                resultMessage = "You got it wrong!"
                playChime(correct: false)
            }
            
            if currentQuestion == numberOfQuestions + 2 {
                resultMessage += " Your final score is: \(score)!"
            }
        } else {
            resultTitle = "Can't read answer."
            resultMessage = "Unable to parse your answer."
        }
    }
    
    func playChime(correct: Bool) {
        var audioName = "correctaudio"
        if !correct {
            audioName = "wrongaudio"
        }
        
        if let url = Bundle.main.url(forResource: audioName, withExtension: "m4a") {
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
}

struct Question {
    var text: String
    var answer: Int
}

struct GameView: View {
    var body: some View {
        VStack {
            Text("new")
        }
    }
}

extension Text {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
