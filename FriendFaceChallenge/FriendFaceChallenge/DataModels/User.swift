//
//  User.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import Foundation

struct User: Codable {
    var id: UUID
    var isActive: Bool
    
    var name: String
    var age: Int16
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    
    var tags: [String]
    var friends: [Friend]
    
    init(id: UUID, isActive: Bool, name: String, age: Int16, company: String,
         email: String, address: String, about: String, registered: Date,
         tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    init(cachedUser: CachedUser) {
        self.id = cachedUser.wrappedID
        self.isActive = cachedUser.isActive
        self.name = cachedUser.wrappedName
        self.age = cachedUser.age
        self.company = cachedUser.wrappedCompany
        self.email = cachedUser.wrappedEmail
        self.address = cachedUser.wrappedAddress
        self.about = cachedUser.wrappedAbout
        self.registered = cachedUser.wrappedRegistered
        self.tags = cachedUser.wrappedTags.components(separatedBy: ",")
        
        let cachedFriendArray = cachedUser.friendsArray
        self.friends = [Friend]()
        
        for cachedFriend in cachedFriendArray {
            self.friends.append(Friend(id: cachedFriend.wrappedID, name: cachedFriend.wrappedName))
        }
    }
}
