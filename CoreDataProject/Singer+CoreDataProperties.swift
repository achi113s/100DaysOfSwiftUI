//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Giorgio Latour on 5/1/23.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown First Name"
    }
    
    var wrappedLastName: String {
        lastName ?? "Unknown Last Name"
    }
}

extension Singer : Identifiable {

}
