//
//  ContentView.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import SwiftUI

struct ContentView: View {
//    @State private var users = [User]()
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        Text(user.wrappedName)
                        Spacer()
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(maxWidth: 10)
                            .opacity(0.8)
                    }
                }
            }
            .task {
                await fetchUsers()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func fetchUsers() async {
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            
            await MainActor.run {
                // The MainActor can only run one thing at a time. The fetchUsers()
                // function is an async one, so it can be run at the same time
                // as UI code, which is done by the MainActor. If we try to updateCache
                // in the async context, we may change CoreData as UI code is running.
                // By asking the MainActor to run it, we eliminate that possibility.
                updateCache(with: users)
            }
        } catch {
            print("Data fetch failed. Loading from CoreData")
        }
    }
    
    func updateCache(with downloadedUsers: [User]) {
        for user in downloadedUsers {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = user.age
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                
                cachedUser.addToFriends(cachedFriend)
            }
        }
        
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
            print("Could not save users to CoreData.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
