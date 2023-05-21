//
//  Person.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import Foundation

struct Person: Codable, Comparable, Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var imageName: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}
