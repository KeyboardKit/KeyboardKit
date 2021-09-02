//
//  EmojiKeyboardConfiguration.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Foundation
import SwiftUI

/**
 This struct can be used to configure an `EmojiKeyboard`.
 
 This struct has a few standard values, which you can access
 with the static `standard` properties.
 
 Note that the struct has both an `itemSize` and a `font`. A
 lazy grid can use the itemSize as a precalculated cell size
 and then apply the font to each emoji.
 */
public struct EmojiKeyboardConfiguration {
    
    public init(
        itemSize: CGFloat = 40,
        font: Font = .system(size: 33),
        categoryFont: Font = .system(size: 20),
        rows: Int = 5,
        horizontalSpacing: CGFloat = 10,
        verticalSpacing: CGFloat = 6) {
        self.itemSize = itemSize
        self.font = font
        self.categoryFont = categoryFont
        self.rows = rows
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
    
    public let itemSize: CGFloat
    public let font: Font
    public let categoryFont: Font
    public let rows: Int
    public let horizontalSpacing: CGFloat
    public let verticalSpacing: CGFloat
    
    var totalHeight: CGFloat { CGFloat(rows) * itemSize }
    
    public static let standardLargePadLandscape = EmojiKeyboardConfiguration(rows: 8)
    public static let standardLargePadPortrait = EmojiKeyboardConfiguration(rows: 5)
    public static let standardPadLandscape = EmojiKeyboardConfiguration(rows: 5)
    public static let standardPadPortrait = EmojiKeyboardConfiguration(rows: 3)
    public static let standardPhoneLandscape = EmojiKeyboardConfiguration(rows: 3)
    public static let standardPhonePortrait = EmojiKeyboardConfiguration(rows: 5)
}
