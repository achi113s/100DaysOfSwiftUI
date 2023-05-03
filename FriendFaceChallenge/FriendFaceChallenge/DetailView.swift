//
//  DetailView.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import SwiftUI

struct DetailView: View {
    @State var user: User
    
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
                        Text("\(user.name), \(user.age)")
                            .font(.title2)
                        Text("Member Since: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
                            .font(.caption2)
                    }
                    Circle()
                        .fill(user.isActive ? .green : .red)
                        .frame(maxWidth: 10)
                }
            }
            
            Section("Contact") {
                Text(user.address)
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Friends") {
                List(user.friends, id: \.id) { friend in
                    HStack {
                        Text(friend.name)
                    }
                }
            }
            
            Section("Tags") {
                List(user.tags, id: \.self) { tag in
                    HStack {
                        Text(tag)
                    }
                }
            }
        }
        .navigationTitle("\(user.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let user = User(id: UUID(), isActive: true, name: "Homer Simpson", age: 48, company: "Nuclear", email: "homer.simpson@springville.com", address: "123 St., Springville, IL", about: "He's big.", registered: Date(), tags: ["big", "yellow"], friends: [Friend(id: UUID(), name: "Marge Simpson")])
    
    static var previews: some View {
        DetailView(user: user)
    }
}
