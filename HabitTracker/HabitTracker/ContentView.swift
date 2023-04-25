//
//  ContentView.swift
//  HabitTracker
//
//  Created by Giorgio Latour on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                Text("hello")
            }
            .navigationTitle("iStreak")
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .tint(.black)
            .sheet(isPresented: $showAddHabit) {
                AddHabitView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
