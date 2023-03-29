//
//  KeyboardFont.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-30.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This struct represents a font to be used in the keyboard.

 This type makes it possible to use fonts in `Codable` types.
 */
public struct KeyboardFont: Codable {

    public init(
        type: KeyboardFontType,
        weight: KeyboardFontWeight
    ) {
        self.type = type
        self.weight = weight
    }

    public var type: KeyboardFontType
    public var weight: KeyboardFontWeight
}

public extension KeyboardFont {

    /// Get the native font for the font style.
    var font: Font {
        type.font.weight(weight.fontWeight)
    }
}
