//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Giorgio Latour on 6/27/23.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    selectedUser = User()
                }
                .sheet(item: $selectedUser) { user in
                    Text(user.id)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
