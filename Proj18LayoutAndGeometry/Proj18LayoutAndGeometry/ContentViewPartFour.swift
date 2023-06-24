//
//  ContentViewPartFour.swift
//  Proj18LayoutAndGeometry
//
//  Created by Giorgio Latour on 6/18/23.
//

import SwiftUI

struct ContentViewPartFour: View {
    @State private var showCheckMark = -60
    @State private var scanSuccess = false
    @State private var progressCircles = 2
    
    var body: some View {
        ZStack {
            ForEach(0..<19) { indexOne in
                ForEach(1..<11) { index in
                    Circle()
                        .frame(width: 5, height: 5)
                        .scaleEffect(CGFloat(index) * 0.2 + 0.5)
                        .offset(x: Double(index) * 15)
                }
                .rotationEffect(.degrees(Double(-indexOne) * 10.0))
            }
        }
    }
}

struct ContentViewPartFour_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPartFour()
    }
}


//VStack {
//    Image(systemName: "checkmark")
//        .font(.system(size: 60))
//        .clipShape(Rectangle().offset(x: scanSuccess ? 0 : -60))
//}
//.onLongPressGesture {
//    withAnimation(.easeInOut(duration: 1)) {
//        scanSuccess.toggle()
//    }
//}
