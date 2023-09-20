//
//  Emoji+Character.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-01-07.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Character {

    /**
     Whether or not the character is a an emoji.
     */
    var isEmoji: Bool {
        let v15 = "🫨🫸🫷🪿🫎🪼🫏🪽🪻🫛🫚🪇🪈🪮🪭🩷🩵🩶🪯🛜"
        return isCombinedEmoji || isSimpleEmoji || v15.contains(self)
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
