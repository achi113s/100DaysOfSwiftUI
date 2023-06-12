//
//  ContentView.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/11/23.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack Tapped")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
