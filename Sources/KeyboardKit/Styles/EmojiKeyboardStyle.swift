//
//  EmojiKeyboardStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Foundation
import SwiftUI

/**
 This style can be applied to emoji keyboard views, like the
 ``EmojiKeyboard`` or ``EmojiCategoryKeyboard`` to customize
 things like the font, number of rows, item spacing etc.
 
 Note that the style has both an ``itemSize`` and a ``font``
 Lazy grids can use the ``itemSize`` as a precalculated cell
 size, then apply the ``font`` to each emoji.
 */
public struct EmojiKeyboardStyle {
    
    /**
     Create an autocomplete toolbar item style.
     
     - Parameters:
       - itemSize: The item size to use, by default `40`.
       - font: The font to apply to the emojis, by default `.system(size: 33)`.
       - categoryFont: The font to apply to the category label, by default `.system(size: 20)`.
       - systemFont: The font to apply to the system button, by default `.system(size: 16)`.
       - rows: The number of rows to use in the keyboard, by default `5`.
       - horizontalSpacing: The horizontal spacing to use, by default `10`.
       - verticalSpacing: The vertical spacing to use, by default `6`.
       - selectedCategoryColor: The color to apply to the selected badge, by default `.black.opacity(0.1)`.
     */
    public init(
        itemSize: CGFloat = 40,
        font: Font = .system(size: 33),
        categoryFont: Font = .system(size: 20),
        systemFont: Font = .system(size: 16),
        rows: Int = 5,
        horizontalSpacing: CGFloat = 10,
        verticalSpacing: CGFloat = 6,
        selectedCategoryColor: Color = Color.black.opacity(0.1)) {
        self.itemSize = itemSize
        self.font = font
        self.categoryFont = categoryFont
        self.systemFont = systemFont
        self.rows = rows
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.selectedCategoryColor = selectedCategoryColor
    }
    
    /**
     The item size to use.
     */
    public var itemSize: CGFloat
    
    /**
     The font to apply to the emojis.
     */
    public var font: Font
    
    /**
     The font to apply to the category label.
     */
    public var categoryFont: Font
    
    /**
     The font to apply to the system button.
     */
    public var systemFont: Font
    
    /**
     The number of rows to use in the keyboard.
     */
    public var rows: Int
    
    /**
     The horizontal spacing to use.
     */
    public var horizontalSpacing: CGFloat
    
    /**
     The vertical spacing to use.
     */
    public var verticalSpacing: CGFloat
    
    /**
     The color to apply to the selected badge.
     */
    public var selectedCategoryColor: Color
    
    /**
     The total keyboard height.
     */
    public var totalHeight: CGFloat { CGFloat(rows) * itemSize }
}

public extension EmojiKeyboardStyle {
    
    static let standardLargePadLandscape = EmojiKeyboardStyle(rows: 6)
    static let standardLargePadPortrait = EmojiKeyboardStyle(rows: 5)
    static let standardPadLandscape = EmojiKeyboardStyle(rows: 5)
    static let standardPadPortrait = EmojiKeyboardStyle(rows: 3)
    static let standardPhoneLandscape = EmojiKeyboardStyle(rows: 3)
    static let standardPhonePortrait = EmojiKeyboardStyle(rows: 5)
}
