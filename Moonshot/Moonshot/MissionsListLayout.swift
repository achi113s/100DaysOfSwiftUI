//
//  MissionsListLayout.swift
//  Moonshot
//
//  Created by Giorgio Latour on 4/18/23.
//

import SwiftUI

struct MissionsListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.95))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .preferredColorScheme(.dark)
        }
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct MissionsListLayout_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionsListLayout(astronauts: astronauts, missions: missions)
    }
}
