//
//  DetailView.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import MapKit
import SwiftUI

struct DetailView: View {
    var person: Person
    
    @State var mapRegion: MKCoordinateRegion
    
    var annotations: [Marker]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(fromFileWithPath: FileManager.documentsDirectory.appendingPathComponent(person.imageFileName, conformingTo: .jpeg).path(), sfSymbolBackup: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
                .clipShape(Circle())
                .shadow(radius: 5, y: 2)
            
            VStack {
                Text("\(person.firstName) \(person.lastName)")
                    .font(Font.title)
                
                Text("\(person.note)")
            }
            
            Map(coordinateRegion: $mapRegion, annotationItems: annotations) {
                MapMarker(coordinate: $0.coordinate)
            }
            
            
            Spacer()
        }
    }
    
    init(person: Person) {
        self.person = person
        
        _mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)))
        
        self.annotations = [Marker(coordinate: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude))]
    }
}
