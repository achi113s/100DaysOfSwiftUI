//
//  Resources.swift
//  Flashzilla
//
//  Created by Giorgio Latour on 6/12/23.
//

import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}
