//
//  FileManager-DocumentsDirectory.swift
//  Faces
//
//  Created by Giorgio Latour on 5/21/23.
//

import UIKit
import UniformTypeIdentifiers

extension FileManager {
    static var documentsDirectory: URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
