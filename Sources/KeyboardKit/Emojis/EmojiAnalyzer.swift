//
//  EmojiAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze emoji information for stings and characters.

 Implementing the protocol will extend the implementing type
 with functions that use `String` and `Character` extensions
 with the same name. You can use the extensions directly and
 ignore the protocol, but the protocol exposes functionality
 to the library documentation.
 */
public protocol EmojiAnalyzer {}

public extension EmojiAnalyzer {

    /**
     Whether or not the string contains an emoji.
     */
    func containsEmoji(_ string: String) -> Bool {
        string.containsEmoji
    }

    /**
     Whether or not the string only contains emojis.
     */
    func containsOnlyEmojis(_ string: String) -> Bool {
        string.containsOnlyEmojis
    }

    /**
     Extract all emoji characters from the string.
     */
    func emojis(in string: String) -> [Character] {
        string.emojis
    }

    /**
     Extract all emoji scalars from the string.
     */
    func emojiScalars(in string: String) -> [UnicodeScalar] {
        string.emojiScalars
    }

    /**
     Extract all emojis in the string.
     */
    func emojiString(in string: String) -> String {
        string.emojiString
    }

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

    /**
     Whether or not the string is a single emoji.
     */
    func isSingleEmoji(_ string: String) -> Bool {
        string.isSingleEmoji
    }
}


// MARK: - Character

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


// MARK: - String

public extension String {

    /**
     Whether or not the string contains an emoji.
     */
    var containsEmoji: Bool {
        contains { $0.isEmoji }
    }

    /**
     Whether or not the string only contains emojis.
     */
    var containsOnlyEmojis: Bool {
        !isEmpty && !contains { !$0.isEmoji }
    }

    /**
     Extract all emoji characters from the string.
     */
    var emojis: [Character] {
        filter { $0.isEmoji }
    }

    /**
     Extract all emoji scalars from the string.
     */
    var emojiScalars: [UnicodeScalar] {
        filter { $0.isEmoji }.flatMap { $0.unicodeScalars }
    }

    /**
     Extract all emojis in the string.
     */
    var emojiString: String {
        emojis.map { String($0) }.reduce("", +)
    }

    /**
     Whether or not the string is a single emoji.
     */
    var isSingleEmoji: Bool {
        count == 1 && containsEmoji
    }
}
