//
//  ContentView.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import MapKit
import SwiftUI

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people, id: \.self) { person in
                    NavigationLink(destination: DetailView(person: person)) {
                        HStack {
                            Image(fromFileWithPath: FileManager.documentsDirectory.appendingPathComponent(person.imageFileName, conformingTo: .jpeg).path(), sfSymbolBackup: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(radius: 5, y: 2)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(person.firstName) \(person.lastName)")
                                Text(person.note)
                                    .font(Font.footnote)
                            }
                        }
                    }
                }
                .onDelete {
                    viewModel.removeAt(offsets: $0)
                    viewModel.save()
                }
            }
            .toolbar(content: {
                ToolbarItem {
                    Button {
                        viewModel.showingImagePicker = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    EditButton()
                }
            })
            .navigationTitle("Faces")
            .onChange(of: viewModel.inputImage, perform: { newValue in
                viewModel.showingPersonNameInput = true
            })
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .alert("Add a Name", isPresented: $viewModel.showingPersonNameInput) {
                TextField("First Name", text: $viewModel.personFirstName)
                TextField("Last Name", text: $viewModel.personLastName)
                TextField("Note", text: $viewModel.personNote)
                Button("OK") {
                    viewModel.createPerson()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
