//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Giorgio Latour on 4/18/23.
//

import SwiftUI

struct CrewScrollView: View {
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct CrewScrollView_Previews: PreviewProvider {
    static let crew = [CrewMember(role: "Commander", astronaut: Astronaut(id: "armstrong", name: "Neil A. Armstrong", description: "Example."))]
    
    static var previews: some View {
        CrewScrollView(crew: crew)
    }
}
