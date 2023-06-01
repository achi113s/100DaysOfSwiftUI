//
//  Prospect.swift
//  HotProspects
//
//  Created by Giorgio Latour on 5/31/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = "Anonymous"
    var emailAddress: String = ""
    var isContacted: Bool = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
}
