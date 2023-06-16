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
//        Text("Hello, World!")
//            .background(.red)
//            .padding(20)
//            .background(.yellow)
        
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
        
        Image("choonsik")
            .frame(width: 100, height: 100)
            .border(.blue)
        
        // ^^ Here, ContentView offers the whole screen to the frame view. It says
        // it needs 100 by 100 space. Then, the image, being a child of the frame
        // and not being resizeable, says it needs a larger area.
        // The image gets positioned in the
        // center of the frame with the dimenions it wants, even though
        // the frame is specified to be 100 by 100. If we add a blue border,
        // we can see that the frame is there with a huge image in the center.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
