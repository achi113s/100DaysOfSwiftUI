//
//  ContentView.swift
//  Proj18LayoutAndGeometry
//
//  Created by Giorgio Latour on 6/15/23.
//

import SwiftUI

// Steps for SwiftUI Layouts
// 1. A parent view proposes a size for its child.
// 2. Based on that information, the child then chooses its own size and the parent must respect that choice.
// 3. The parent then positions the child in its coordinate space.

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .background(.red)
            .padding(20)
            .background(.yellow)
        
        // SwiftUI: You can have the whole screen ContentView, how much do you need?
        // ContentView: You can have the whole screen yellowBackground. How much do you need?
        // YellowBackground: You can have the whole screen padding(20), how much do you need?
        // Padding(20): You can have the whole screen minus 20 points on each side, redBackground, how much do you need?
        // RedBackground: You can have the whole screen, Text. How much do you need?
        // Text: I only need X by Y space.
        // RedBackground: I need X by Y space.
        // Padding(20): I need X by Y plus 20 points on each side.
        // YellowBackground: I need X by Y plus 20 points on each side.
        // ContentView: Hey SwiftUI, I need X by Y plus 20 points on each side!
        // SwiftUI: Ok great, I'll center you.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
