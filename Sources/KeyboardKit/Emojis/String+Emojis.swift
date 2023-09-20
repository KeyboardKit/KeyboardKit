//
//  String+Emojis.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

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
