//
//  Person.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import Foundation
import CoreLocation

struct Person: Codable, Comparable, Identifiable, Hashable {
    var id: UUID
    var firstName: String
    var lastName: String
    var note: String
    var imageFileName: String
    var latitude: Double
    var longitude: Double
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}
