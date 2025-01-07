//
//  Emoji+Unicode.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Emoji {
    
    /// The emoji's unique identifier.
    var unicodeIdentifier: String? {
        char.applyingTransform(.toUnicodeName, reverse: false)
    }
    
    /// The emoji's full, readable unicode name.
    ///
    /// Note that this name may not always be what you want to display to users. For that, use the localized name instead.
    var unicodeName: String {
        unicodeNameComponents
            .joined(separator: " ")
    }
}

private extension Emoji {

    var unicodeNameComponents: [String] {
        unicodeIdentifier?
            .replacingOccurrences(of: "\\N", with: "")
            .replacingOccurrences(of: "\\n", with: "")
            .replacingOccurrences(of: "{", with: "")
            .split(separator: "}")
            .map { $0.capitalized } ?? []
    }
}
