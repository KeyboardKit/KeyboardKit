//
//  Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This type represents an emoji and serves as a namespace for
 emoji-related types and functionality.
 */
public struct Emoji: Equatable, Codable, Identifiable {
    
    /// Create an emoji from a certain character.
    public init(_ char: Character) {
        self.char = String(char)
    }
    
    /// Create an emoji from a certain character.
    public init(_ char: String) {
        self.char = char
    }
   
    /// The emoji character string.
    public let char: String
}

public extension Emoji {
    
    /// The emoji's unique identifier.
    var id: String { char }
}
