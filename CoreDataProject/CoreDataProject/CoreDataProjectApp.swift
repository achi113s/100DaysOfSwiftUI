//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Giorgio Latour on 5/1/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
