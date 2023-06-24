//
//  ContentView.swift
//  DiceRolling
//
//  Created by Giorgio Latour on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var dieOneValue = 1
    @State private var dieTwoValue = 1
    @State private var dieSides = 4
    @State private var showingSettingsView = false
    
    @StateObject private var rolls = DiceRolls()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 36) {
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        withAnimation {
                            dieOneValue = Int.random(in: 1...dieSides)
                            dieTwoValue = Int.random(in: 1...dieSides)
                            
                            rolls.addRoll(
                                DiceRoll(
                                    dieOneValue: self.dieOneValue,
                                    dieTwoValue: self.dieTwoValue
                                )
                            )
                        }
                    } label: {
                        Text("Roll Dice")
                            .font(.title2)
                    }
                    .buttonStyle(.bordered)
                    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
