//
//  ImageFromDocuments.swift
//  Faces
//
//  Created by Giorgio Latour on 5/22/23.
//

import SwiftUI

extension Image {
    init(fromFileWithPath path: String, sfSymbolBackup: String) {
        if let uiImage = UIImage(contentsOfFile: path) {
            self.init(uiImage: uiImage)
        } else {
            self.init(systemName: sfSymbolBackup)
        }
    }
}
