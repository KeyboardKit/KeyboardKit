//
//  EmojiStringAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze emoji information for a string.

 This protocol is implemented by `String`, which uses itself
 as the required string.
 */
public protocol EmojiStringAnalyzer {

    /// The string to analyze.
    var string: String { get }
}

extension String: EmojiStringAnalyzer {

    public var string: String { self }
}

public extension EmojiStringAnalyzer {

    /**
     Whether or not the string contains an emojil.
     */
    var containsEmoji: Bool {
        string.contains { $0.isEmoji }
    }

    /**
     Whether or not the string only contains emojis.
     */
    var containsOnlyEmojis: Bool {
        !string.isEmpty && !string.contains { !$0.isEmoji }
    }

    /**
     Extract all emoji characters from the string.
     */
    var emojis: [Character] {
        string.filter { $0.isEmoji }
    }

    /**
     Extract all emoji scalars from the string.
     */
    var emojiScalars: [UnicodeScalar] {
        string.filter { $0.isEmoji }.flatMap { $0.unicodeScalars }
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
        string.count == 1 && containsEmoji
    }
}
