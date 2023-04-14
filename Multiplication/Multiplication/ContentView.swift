//
//  ContentView.swift
//  Multiplication
//
//  Created by Giorgio Latour on 4/13/23.
//

import SwiftUI

struct ContentView: View {
    @State var isGameActive: Bool = false
    @State var minTimesTable: Int = 0
    @State var maxTimesTable: Int = 10
    @State var numberOfQuestions: Int = 0
    
    @State var questions: [Question] = [Question]()
    
    let cloudTextShadowRadius: CGFloat = 2.0
    
    let DeepKoamaru: Color = Color("#30336b")
    let GreenDarnerTail: Color = Color("#74b9ff")
    
    var body: some View {
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
            }
            .padding()
        }
    }
    
    func generateQuestions() {
        for _ in 0..<numberOfQuestions+2 {
            let minNum = minTimesTable + 2
            let maxNum = maxTimesTable + 2
            
            let first = Int.random(in: minNum...maxNum)
            let second = Int.random(in: minNum...maxNum)
            
            let question = Question(text: "\(first) × \(second)", answer: first*second)
            questions.append(question)
        }
    }
}

struct Question {
    var text: String
    var answer: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
