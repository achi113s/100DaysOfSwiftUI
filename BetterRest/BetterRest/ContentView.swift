//
//  ContentView.swift
//  BetterRest
//
//  Created by Giorgio Latour on 4/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("How much do you want to sleep?")
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12,
                        step: 0.25)
                Text("Daily Coffee Intake")
                    .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    func calculateBedtime() {
        print("f")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
