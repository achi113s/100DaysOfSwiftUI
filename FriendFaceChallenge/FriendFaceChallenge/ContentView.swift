//
//  ContentView.swift
//  FriendFaceChallenge
//
//  Created by Giorgio Latour on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        Text(user.name)
                        Spacer()
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(maxWidth: 10)
                            .opacity(0.8)
                    }
                }
            }
            .task {
                await loadUsers()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadUsers() async {
        if !users.isEmpty {
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("Invalid Data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
