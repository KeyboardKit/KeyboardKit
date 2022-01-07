//
//  String+Emojis.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//
//  Original implementation:
//  https://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
//

import Foundation

public extension Character {
    
    /**
     Whether or not the character is a an emoji.
     */
    var isEmoji: Bool { isSimpleEmoji || isCombinedEmoji }
    
    /**
     Whether or not the character consists of unicodeScalars
     that will be merged into an emoji.
     */
    var isCombinedEmoji: Bool {
        guard unicodeScalars.count > 1 else { return false }
        return unicodeScalars.first?.properties.isEmoji ?? false
    }
    
    /**
     Whether or not the character is a "simple emoji", which
     is one scalar and presented to the user as an Emoji.
     */
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
}

public extension String {

    /**
     Whether or not the string contains an emojil.
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
