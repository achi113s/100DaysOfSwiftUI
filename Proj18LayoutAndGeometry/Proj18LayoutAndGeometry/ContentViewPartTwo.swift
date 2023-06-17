//
//  ContentViewPartTwo.swift
//  Proj18LayoutAndGeometry
//
//  Created by Giorgio Latour on 6/17/23.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geometryProxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geometryProxy.frame(in: .global).midX) x \(geometryProxy.frame(in: .global).midY)")
                        print("Local center: \(geometryProxy.frame(in: .local).midX) x \(geometryProxy.frame(in: .local).midY)")
                        print("Custom center: \(geometryProxy.frame(in: .named("Custom")).midX) x \(geometryProxy.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            
            Text("Right")
        }
    }
}

struct ContentViewPartTwo: View {
    var body: some View {
        // Position view in an exact location.
        // Here, the background uses the position's
        // view for the background, which is all available space.
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //            .position(x: 100, y: 100)
        //            .background(.red)
        
        // Here, the background uses the text's
        // view for the background, which is only the small area.
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //            .background(.red)
        //            .position(x: 100, y: 100)
        
        // When we use the offset modifier, we change the location
        // where the view should be rendered without changing
        // its underlying dimensions. When we attach Background,
        // we're using the original position of the text. The Offset
        // does not affect the background modifier.
        //        Text("Hello, world!")
        //            .offset(x: 100, y: 100)
        //            .background(.red)
        
        // Here we have the opposite to above. The offset view
        // tells SwiftUI to render the child view elsewhere, which
        // includes the background.
        //        Text("Hello, world!")
        //            .background(.red)
        //            .offset(x: 100, y: 100)
        
        // GeometryReader allows us to read the size proposed
        // by the parent view and use that to manipulate our view.
        // geometryProxy contains the parent's proposed size, plus
        // any safe area insets, and a method for reading frame values.
        //        GeometryReader { geometryProxy in
        //            Text("Hello, world!")
        //                .frame(width: geometryProxy.size.width * 0.9)
        //                .background(.red)
        //        }
        
        // GeometryReader has a flexible preferred size, which means it'll
        // expand to take up more space as needed.
        //        VStack {
        //            GeometryReader { geometryProxy in
        //                Text("Hello, world!")
        //                    .frame(width: geometryProxy.size.width * 0.9)
        //                    .background(.red)
        //            }
        //            .background(.green)
        //
        //            Text("More text.")
        //            Text("More text.")
        //            Text("More text.")
        //            Text("More text.")
        //                .background(.blue)
        //        }
        
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

struct ContentViewPartTwo_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPartTwo()
    }
}
