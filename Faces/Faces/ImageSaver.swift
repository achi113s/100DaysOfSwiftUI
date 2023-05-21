//
//  ImageSaver.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToDocuments(image: UIImage, imageName: String) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: FileManager.documentsDirectory.appendingPathComponent(imageName, conformingTo: .jpeg), options: [.atomic, .completeFileProtection])
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
