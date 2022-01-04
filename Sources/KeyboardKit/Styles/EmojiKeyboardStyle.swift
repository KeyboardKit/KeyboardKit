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
       - selectedCategoryColor: The color to apply to the selected badge, by default `.primary.opacity(0.1)`.
       - abcText: The text to use for the ABC button, by default `ABC`.
       - backspaceIcon: The icon to use for the backspace button, by default `.keyboardBackspace`.
     */
    public init(
        itemSize: CGFloat = 40,
        font: Font = .system(size: 33),
        categoryFont: Font = .system(size: 20),
        systemFont: Font = .system(size: 16),
        rows: Int = 5,
        horizontalSpacing: CGFloat = 10,
        verticalSpacing: CGFloat = 6,
        selectedCategoryColor: Color = .primary.opacity(0.1),
        abcText: String = "ABC",
        backspaceIcon: Image = .keyboardBackspace) {
        self.itemSize = itemSize
        self.font = font
        self.categoryFont = categoryFont
        self.systemFont = systemFont
        self.rows = rows
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.selectedCategoryColor = selectedCategoryColor
        self.abcText = abcText
        self.backspaceIcon = backspaceIcon
    }
    
    /**
     The text to use for the ABC button.
     */
    public var abcText: String
    
    /**
     The icon to use for the backspace button.
     */
    public var backspaceIcon: Image
    
    /**
     The font to apply to the category label.
     */
    public var categoryFont: Font
    
    /**
     The font to apply to the emojis.
     */
    public var font: Font
    
    /**
     The horizontal spacing to use.
     */
    public var horizontalSpacing: CGFloat
    
    /**
     The item size to use.
     */
    public var itemSize: CGFloat
    
    /**
     The number of rows to use in the keyboard.
     */
    public var rows: Int
    
    /**
     The color to apply to the selected badge.
     */
    public var selectedCategoryColor: Color
    
    /**
     The font to apply to the system button.
     */
    public var systemFont: Font
    
    /**
     The total keyboard height.
     */
    public var totalHeight: CGFloat { CGFloat(rows) * itemSize }
    
    /**
     The vertical spacing to use.
     */
    public var verticalSpacing: CGFloat
}

public extension EmojiKeyboardStyle {
    
    static let standardLargePadLandscape = EmojiKeyboardStyle(rows: 6)
    static let standardLargePadPortrait = EmojiKeyboardStyle(rows: 5)
    static let standardPadLandscape = EmojiKeyboardStyle(rows: 5)
    static let standardPadPortrait = EmojiKeyboardStyle(rows: 3)
    static let standardPhoneLandscape = EmojiKeyboardStyle(rows: 3)
    static let standardPhonePortrait = EmojiKeyboardStyle(rows: 5)
    
    static func standard(for context: KeyboardContext) -> EmojiKeyboardStyle {
        let isPortrait = context.screenOrientation.isPortrait
        if context.device.isPhone {
            return isPortrait ? .standardPhonePortrait : .standardPhoneLandscape
        }
        if context.screen.isIpadProLargeScreen {
            return isPortrait ? .standardLargePadPortrait : .standardLargePadLandscape
        }
        return isPortrait ? .standardPadPortrait : .standardPadLandscape
    }
}
