//
//  Character+Emoji.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-11-01.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Character {

    /// Whether the character is a an emoji.
    var isEmoji: Bool {
        let v15 = "🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜"
        return isCombinedEmoji || isSimpleEmoji || v15.contains(self)
    }

    /// Whether the character is a multi-scalar emoji.
    var isCombinedEmoji: Bool {
        let scalars = unicodeScalars
        guard scalars.count > 1 else { return false }
        return scalars.first?.properties.isEmoji ?? false
    }

    /// Whether the character is a one-scalar emoji.
    var isSimpleEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && scalar.value > 0x238C
    }
}
