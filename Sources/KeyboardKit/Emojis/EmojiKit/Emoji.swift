//
//  Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type represents an emoji character and is used as a
/// namespace for emoji-related types and functionality.
public struct Emoji: Equatable, Codable, Hashable, Identifiable, Sendable {
    
    /// Create an emoji from a certain character.
    public init(_ char: Character) {
        self.char = String(char)
    }
    
    /// Create an emoji from a certain string.
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


public extension Array where Element == Emoji {

    /// Get the emoji at a certain index, if any.
    func emoji(at index: Int) -> Emoji? {
        let isValid = index >= 0 && index < count
        return isValid ? self[index] : nil
    }

    /// The first index of a certain emoji, if any.
    func firstIndex(of emoji: Emoji) -> Int? {
        firstIndex {
            $0.neutralSkinToneVariant == emoji.neutralSkinToneVariant
        }
    }
}
