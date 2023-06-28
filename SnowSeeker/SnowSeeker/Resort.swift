//
//  Resort.swift
//  SnowSeeker
//
//  Created by Giorgio Latour on 6/27/23.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    // static let in a struct is essentially a lazy variable since it's only
    // created right before it is referenced
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
