//
//  ContentView.swift
//  DiceRolling
//
//  Created by Giorgio Latour on 6/21/23.
//

import Combine
import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var dieOneValue = 1
    @State private var dieTwoValue = 1
    @State private var dieSides = 4
    @State private var showingSettingsView = false
    
    @StateObject private var rolls = DiceRolls()
    
    @State private var engine: CHHapticEngine?
    
    @State private var randomCounts = 5
    @State private var timer: Timer?
    @State private var rollButtonDisabled = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 36) {
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        rollButtonDisabled = true
                        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { _ in
                            dieOneValue = Int.random(in: 1...dieSides)
                            dieTwoValue = Int.random(in: 1...dieSides)
                            
                            randomCounts -= 1
                            
                            if randomCounts == 0 {
                                timer?.invalidate()
                                randomCounts = 5
                                rollButtonDisabled = false
                                
                                rolls.addRoll(
                                    DiceRoll(
                                        dieOneValue: self.dieOneValue,
                                        dieTwoValue: self.dieTwoValue
                                    )
                                )
                            }
                        })
                        
                        complexDiceRoll()
                    } label: {
                        Text("Roll Dice")
                            .font(.title2)
                    }
                    .buttonStyle(.bordered)
                    .accessibilityHint("Rolls dice to get a random pair of numbers.")
                    .disabled(rollButtonDisabled)
                    
                    HStack {
                        Text("Sides:")
                            .font(.title2)
                        Picker("Sides", selection: $dieSides) {
                            ForEach(rolls.possibleSides, id: \.self) { sides in
                                Text("\(sides)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                .onAppear(perform: prepareHapticEngine)
                
                HStack {
                    DieView(dieValue: String(dieOneValue))
                    DieView(dieValue: String(dieTwoValue))
                }
                
                Text("Total: \(dieOneValue + dieTwoValue)")
                    .font(.title)
                
                Form {
                    Section("Previous Rolls") {
                        List(rolls.rolls) { roll in
                            HStack {
                                Text("\(roll.dieOneValue), \(roll.dieTwoValue)")
                                Spacer()
                                Text("Total: \(roll.dieOneValue + roll.dieTwoValue)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Dice Roller 🎲")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSettingsView = true
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                }
            }
            .sheet(isPresented: $showingSettingsView) {
                SettingsView()
            }
        }
        .environmentObject(rolls)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func prepareHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        print("Hardware supports haptics!")
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            print("Haptic engine started!")
        } catch {
            print("There was a problem starting the haptic engine: \(error.localizedDescription)")
        }
    }
    
    func complexDiceRoll() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        print("Hardware supports haptics!")
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.8, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1.0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("There was a problem creating the haptic pattern: \(error.localizedDescription)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
