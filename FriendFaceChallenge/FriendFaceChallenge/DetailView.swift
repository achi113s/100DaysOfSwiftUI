//
//  DetailView.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser
    
    var body: some View {
        Form {
            Section("User") {
                HStack {
                    Circle()
                        .strokeBorder(.secondary, lineWidth: 1).opacity(0.2)
                        .background(Circle().fill(.white))
                        .frame(width: 100, height: 100)
                        .overlay(Text("Profile Picture")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary).opacity(0.8)
                        )
                    
                    Spacer()
                    VStack {
                        Text("\(user.wrappedName), \(user.age)")
                            .font(.title2)
                        Text("Member Since: \(user.wrappedRegistered.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption2)
                    }
                    Circle()
                        .fill(user.isActive ? .green : .red)
                        .frame(maxWidth: 10)
                }
            }
            
            Section("Contact") {
                Text(user.wrappedAddress)
            }
            
            Section("About") {
                Text(user.wrappedAbout)
            }
            
            Section("Friends") {
                List(user.friendsArray, id: \.id) { friend in
                    HStack {
                        Text(friend.wrappedName)
                    }
                }
            }
            
            Section("Tags") {
                List(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                    HStack {
                        Text(tag)
                    }
                }
            }
        }
        .navigationTitle("\(user.wrappedName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
