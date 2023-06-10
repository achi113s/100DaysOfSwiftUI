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
    var dateMet: Date = Date.now
    fileprivate(set) var isContacted: Bool = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    // init with UserDefaults as storage
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        // no saved data
//        people = []
//    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            sortBy(.byNameAsc)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sortBy(_ sortType: SortType) {
        switch sortType {
        case .byDateAsc:
            objectWillChange.send()
            people = people.sorted(by: { $0.dateMet < $1.dateMet })
        case .byDateDesc:
            objectWillChange.send()
            people = people.sorted(by: { $0.dateMet > $1.dateMet })
        case .byNameAsc:
            objectWillChange.send()
            people = people.sorted(by: { $0.name < $1.name })
        case .byNameDesc:
            objectWillChange.send()
            people = people.sorted(by: { $0.name > $1.name })
        }
        
    }
}
