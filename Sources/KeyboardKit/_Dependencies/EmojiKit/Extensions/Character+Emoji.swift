//
//  Character+Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Character {

    /// Whether the character is a an emoji.
    ///
    /// This property will manually add later version emojis
    /// to the check, since they don't
    var isEmoji: Bool {
        if isCombinedEmoji || isSimpleEmoji { return true }
        return isVersion15OrLaterEmoji
    }
    
    /// Whether the character is a multi-scalar emoji.
    var isCombinedEmoji: Bool {
        let scalars = unicodeScalars
        guard scalars.count > 1 else { return false }
        return scalars.first?.properties.isEmoji ?? false
    }
    
    /// Whether the character is an emoji which was released
    /// in version 15 or later.
    var isVersion15OrLaterEmoji: Bool {
        let versions = EmojiVersion.all.filter { $0.version >= 15 }
        let emojis = versions.flatMap { $0.emojiString }
        return emojis.contains(self)
    }

    /// Whether the character is a one-scalar emoji.
    var isSimpleEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && scalar.value > 0x238C
    }
}
