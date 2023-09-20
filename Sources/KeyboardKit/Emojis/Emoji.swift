//
//  Emoji.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct is just a wrapper around a single character. It
 lets us work in a more structured way with emojis.
 */
public struct Emoji: Equatable, Codable, Identifiable {
    
    /// Create an emoji from a certain character.
    public init(_ char: String) {
        self.char = char
    }
   
    /// The emoji character.
    public let char: String
}

public extension Emoji {
    
    /// The emoji's unique identifier.
    var id: String { char }
}
