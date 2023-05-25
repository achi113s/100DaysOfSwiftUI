//
//  ContentView-ViewModel.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import Foundation
import UIKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var inputImage: UIImage?
        @Published var showingImagePicker: Bool = false
        
        @Published var showingPersonNameInput: Bool = false
        @Published var personFirstName: String = ""
        @Published var personLastName: String = ""
        @Published var personNote: String = ""
        
        @Published private(set) var people: [Person]
        
        @Published var locationFetcher = LocationFetcher()
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
                people.sort()
            } catch {
                people = [Person]()
            }
            self.locationFetcher.start()
        }
        
        func createPerson() {
            var latitude = 0.0
            var longitude = 0.0
            
            if let location = self.locationFetcher.lastKnownLocation {
                latitude = location.latitude
                longitude = location.longitude
            }
            
            let newPerson = Person(id: UUID(), firstName: personFirstName, lastName: personLastName, note: personNote, imageFileName: UUID().uuidString, latitude: latitude, longitude: longitude)
            
            personFirstName = ""
            personLastName = ""
            personNote = ""
            
            saveCurrentImageToDocuments(withFileName: newPerson.imageFileName)
            
            people.append(newPerson)
            
            people.sort()
            
            save()
        }
        
        func removeAt(offsets: Foundation.IndexSet) {
            people.remove(atOffsets: offsets)
        }
        
        func saveCurrentImageToDocuments(withFileName filename: String) {
            guard let inputImage = inputImage else { return }
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
                print("Success!")
            }
            
            imageSaver.errorHandler = {
                print("Oops! \($0.localizedDescription)")
            }
            
            imageSaver.writeToDocuments(image: inputImage, imageName: filename)
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("unable to save data.")
            }
        }
    }
}
