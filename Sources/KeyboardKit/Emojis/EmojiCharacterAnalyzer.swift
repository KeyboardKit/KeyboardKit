//
//  EmojiCharacterAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze emoji information for characters.

 Implementing the protocol will extend the implementing type
 with additional functionality.

 This protocol is implemented by `Character` and other types
 in this library. `Character` adds more functionality on top
 of these protocol extensions:

 ```swift
 let char = Character("😀")
 char.isEmoji           // true
 char.isCombinedEmoji   // false
 char.isSimpleEmoji     // true
 ```

 Although you can just use the type extensions and basically
 ignore the protocol, the protocol plays together with other
 analyzer protocols and also makes the functionality show up
 in the library documentation, which by default omits native
 type extensions.
 */
public protocol EmojiCharacterAnalyzer {}

public extension EmojiCharacterAnalyzer {

    /**
     Whether or not a character is a an emoji.
     */
    func isEmoji(_ char: Character) -> Bool {
        char.isEmoji
    }

    /**
     Whether or not the character consists of unicodeScalars
     that will be merged into an emoji.
     */
    func isCombinedEmoji(_ char: Character) -> Bool {
        char.isCombinedEmoji
    }

    /**
     Whether or not the character is a "simple emoji", which
     is a single scalar that is presented as an emoji.
     */
    func isSimpleEmoji(_ char: Character) -> Bool {
        char.isSimpleEmoji
    }
}


// MARK: - Character

extension Character: EmojiCharacterAnalyzer {}

public extension Character {

    /**
     Whether or not the character is a an emoji.
     */
    var isEmoji: Bool {
        isCombinedEmoji || isSimpleEmoji
    }

    /**
     Whether or not the character consists of unicodeScalars
     that will be merged into an emoji.
     */
    var isCombinedEmoji: Bool {
        let scalars = unicodeScalars
        guard scalars.count > 1 else { return false }
        return scalars.first?.properties.isEmoji ?? false
    }

    /**
     Whether or not the character is a "simple emoji", which
     is one scalar and presented to the user as an Emoji.
     */
    var isSimpleEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && scalar.value > 0x238C
    }
}
