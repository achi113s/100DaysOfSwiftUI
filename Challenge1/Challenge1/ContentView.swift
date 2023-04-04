//
//  ContentView.swift
//  Challenge1
//
//  Created by Giorgio Latour on 4/3/23.
//

import SwiftUI

struct ContentView: View {
    @State var inputTemp: Double = 0.0
    @State var inputUnit: Int = 0
    @State var outputUnit: Int = 0
    @FocusState var inputIsFocused: Bool
    
    var inputUnits: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    var outputUnits: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var outputTemp: Double {
        // Use celsius as a base unit
        var tempInCelsius: Double = 0.0
        if inputUnit == 1 {
            tempInCelsius = (inputTemp - 32.0) * (5.0 / 9.0)
        } else if inputUnit == 2 {
            tempInCelsius = inputTemp - 273.15
        } else {
            tempInCelsius = inputTemp
        }
        
        if outputUnit == 1 {
            return (tempInCelsius * (9.0 / 5.0)) + 32
        } else if outputUnit == 2 {
            return tempInCelsius + 273.15
        } else {
            return tempInCelsius
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section {
                        TextField("Input Temperature", value: $inputTemp, format:
                                .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                        
                        Picker("Units", selection: $inputUnit) {
                            ForEach(0..<3, id: \.self) {
                                Text(inputUnits[$0])
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Input Temperature")
                    }
                    
                    Section {
                        Picker("Units", selection: $outputUnit) {
                            ForEach(0..<3, id: \.self) {
                                Text(outputUnits[$0])
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Convert to")
                    }
                    
                    Section {
                        Text(outputTemp, format: .number)
                    } header: {
                        Text("Output Temperature")
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("RosyHighlight"))
                .navigationTitle(Text("🌡️ Converter"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
