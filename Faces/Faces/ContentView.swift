//
//  ContentView.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var faces = ["Toni Morrison", "Tim Cook", "Rollie Williams"]
    var body: some View {
        NavigationView {
            List(faces, id: \.self) { face in
                HStack {
                    Text("Image Here")
                    Text(face)
                }
            }
            .toolbar(content: {
                ToolbarItem {
                    Button {
                        print("add face")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
            .navigationTitle("Faces")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
