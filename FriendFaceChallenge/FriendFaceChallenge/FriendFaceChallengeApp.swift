//
//  FriendFaceChallengeApp.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import SwiftUI

@main
struct FriendFaceChallengeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
