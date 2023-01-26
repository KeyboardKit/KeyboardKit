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
 able to analyze emoji information for strings.

 This protocol is implemented by `String` and other types in
 this library. `String` adds more functionality on top of it:

 ```swift
 let str = "😀 smile!"
 str.containsEmoji          // true
 str.containsOnlyEmojis     // false
 str.emojis                 // 😀
 str.emojiScalars           // ...well, data
 str.emojiString            // "😀"
 str.isSingleEmoji          // false
 ```

 Although you can just use the type extensions and basically
 ignore the protocol, the protocol plays together with other
 analyzer protocols and also makes the functionality show up
 in the library documentation, which by default omits native
 type extensions.
 */
public protocol EmojiStringAnalyzer {}

public extension EmojiStringAnalyzer {

    /// Whether or not the string contains an emoji.
    func containsEmoji(_ string: String) -> Bool {
        string.containsEmoji
    }

    /// Whether or not the string only contains emojis.
    func containsOnlyEmojis(_ string: String) -> Bool {
        string.containsOnlyEmojis
    }

    /// Extract all emoji characters from the string.
    func emojis(in string: String) -> [Character] {
        string.emojis
    }

    /// Extract all emoji scalars from the string.
    func emojiScalars(in string: String) -> [UnicodeScalar] {
        string.emojiScalars
    }

    /// Extract all emojis in the string.
    func emojiString(in string: String) -> String {
        string.emojiString
    }

    /// Whether or not the string is a single emoji.
    func isSingleEmoji(_ string: String) -> Bool {
        string.isSingleEmoji
    }
}


// MARK: -  String

extension String: EmojiStringAnalyzer {}

public extension String {

    /// Whether or not the string contains an emoji.
    var containsEmoji: Bool {
        contains { $0.isEmoji }
    }

    /// Whether or not the string only contains emojis.
    var containsOnlyEmojis: Bool {
        !isEmpty && !contains { !$0.isEmoji }
    }

    /// Extract all emoji characters from the string.
    var emojis: [Character] {
        filter { $0.isEmoji }
    }

    /// Extract all emoji scalars from the string.
    var emojiScalars: [UnicodeScalar] {
        filter { $0.isEmoji }.flatMap { $0.unicodeScalars }
    }

    /// Extract all emojis in the string.
    var emojiString: String {
        emojis.map { String($0) }.reduce("", +)
    }

    /// Whether or not the string is a single emoji.
    var isSingleEmoji: Bool {
        count == 1 && containsEmoji
    }
}
