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
 able to analyze emoji information for a character.

 This protocol is implemented by `Character`, which means it
 gets all the ``EmojiCharacterAnalyzer
 */
public protocol EmojiCharacterAnalyzer: CharacterProvider {}

extension Character: EmojiCharacterAnalyzer {}

public extension EmojiCharacterAnalyzer {

    /**
     Whether or not the character is a an emoji.
     */
    var isEmoji: Bool { isSimpleEmoji || isCombinedEmoji }

    /**
     Whether or not the character consists of unicodeScalars
     that will be merged into an emoji.
     */
    var isCombinedEmoji: Bool {
        let scalars = character.unicodeScalars
        guard scalars.count > 1 else { return false }
        return scalars.first?.properties.isEmoji ?? false
    }

    /**
     Whether or not the character is a "simple emoji", which
     is one scalar and presented to the user as an Emoji.
     */
    var isSimpleEmoji: Bool {
        let scalars = character.unicodeScalars
        guard let firstScalar = scalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
}
