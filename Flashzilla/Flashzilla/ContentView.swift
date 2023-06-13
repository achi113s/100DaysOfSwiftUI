//
//  ContentView.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/11/23.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    // tolerance allows iOS to push the timer's firing to fire with other timers, therefore
    // saving battery by keeping the CPU idle
    @State private var counter = 0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onReceive(timer) { time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()
                    } else {
                        print("The time is now \(time).")
                    }
                    counter += 1
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
