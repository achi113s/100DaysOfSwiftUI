//
//  CachedFriend+CoreDataProperties.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/5/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: NSSet?

    public var wrappedID: UUID { id ?? UUID() }
    
    public var wrappedName: String { name ?? "Unknown Name" }
    
    public var userArray: [CachedUser] {
        let set = user as? Set<CachedUser> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for user
extension CachedFriend {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
