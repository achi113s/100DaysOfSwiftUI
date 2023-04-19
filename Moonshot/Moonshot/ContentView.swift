//
//  ContentView.swift
//  Moonshot
//
//  Created by Giorgio Latour on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    
    private var toolbarButtonImage: String {
        if showingGrid {
            return "list.bullet"
        } else {
            return "square.grid.2x2"
        }
    }
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    MissionsGridLayout(astronauts: astronauts, missions: missions)
                } else {
                    MissionsListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem() {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: toolbarButtonImage)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
