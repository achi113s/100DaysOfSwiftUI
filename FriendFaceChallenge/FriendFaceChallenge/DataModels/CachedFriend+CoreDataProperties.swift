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
    @NSManaged public var userFriend: CachedUser?

    public var wrappedID: UUID { id ?? UUID() }
    
    public var wrappedName: String { name ?? "Unknown Name" }
}

extension CachedFriend : Identifiable {

}
