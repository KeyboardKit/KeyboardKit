//
//  EmojiKeyboardStyle.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Foundation
import SwiftUI

/**
 This style can be applied to emoji keyboard views, like the
 ``EmojiKeyboard`` or ``EmojiCategoryKeyboard`` to customize
 things like the font, number of rows, item spacing etc.
 
 Note that the style has both an ``itemSize`` and ``itemFont``
 parameter. SwiftUI grids use ``itemSize`` as pre-calculated
 cell size, then apply ``itemFont`` to each emoji item. Make
 sure to find a good combination when customizing the values.
 */
public struct EmojiKeyboardStyle {
    
    /**
     Create an autocomplete toolbar item style.
     
     The standard parameter values generates a keyboard that
     is designed as a standard iPhone portrait keyboard.
     
     - Parameters:
       - rows: The number of rows to use in the keyboard, by default `5`.
       - itemSize: The emoji item size to use, by default `40`.
       - itemFont: The font to apply to emojis, by default `.system(size: 33)`.
       - horizontalItemSpacing: The horizontal spacing to use between emojis, by default `10`.
       - verticalItemSpacing: The vertical spacing to use between emojis, by default `6`.
       - verticalCategoryStackSpacing: The vertical spacing to apply to the vertical category keyboard stack, by default `0`.
       - categoryFont: The font to apply to the category label, by default `.system(size: 14)`.
       - systemFont: The font to apply to system buttons, by default `.system(size: 16)`.
       - selectedCategoryColor: The color to apply to the selected badge, by default `.primary.opacity(0.1)`.
       - abcText: The text to use for the ABC button, by default `ABC`.
       - backspaceIcon: The icon to use for the backspace button, by default `.keyboardBackspace`.
     */
    public init(
        rows: Int = 5,
        itemSize: CGFloat = 40,
        itemFont: Font = .system(size: 33),
        horizontalItemSpacing: CGFloat = 10,
        verticalItemSpacing: CGFloat = 6,
        verticalCategoryStackSpacing: CGFloat = 0,
        categoryFont: Font = .system(size: 14),
        systemFont: Font = .system(size: 16),
        selectedCategoryColor: Color = .primary.opacity(0.1),
        abcText: String = "ABC",
        backspaceIcon: Image = .keyboardBackspace
    ) {
        self.itemSize = itemSize
        self.itemFont = itemFont
        self.categoryFont = categoryFont
        self.systemFont = systemFont
        self.rows = rows
        self.horizontalItemSpacing = horizontalItemSpacing
        self.verticalItemSpacing = verticalItemSpacing
        self.verticalCategoryStackSpacing = verticalCategoryStackSpacing
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
     The horizontal spacing to use.
     */
    public var horizontalItemSpacing: CGFloat
    
    /**
     The font to apply to the emojis.
     */
    public var itemFont: Font
    
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
     The vertical spacing to apply to the vertical category keyboard stack.
     */
    public var verticalCategoryStackSpacing: CGFloat
    
    /**
     The vertical spacing to use.
     */
    public var verticalItemSpacing: CGFloat
}

public extension EmojiKeyboardStyle {
    
    /**
     The style to use for large iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardLargePadLandscape = EmojiKeyboardStyle(
        rows: 6,
        itemSize: 60,
        itemFont: .system(size: 50),
        horizontalItemSpacing: 15,
        verticalItemSpacing: 10,
        verticalCategoryStackSpacing: 10,
        categoryFont: .system(size: 18).bold(),
        systemFont: .system(size: 18))
    
    /**
     The style to use for large iPads in portrait.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardLargePadPortrait = EmojiKeyboardStyle(
        rows: 5,
        itemSize: 60,
        itemFont: .system(size: 50),
        horizontalItemSpacing: 10,
        verticalItemSpacing: 7,
        verticalCategoryStackSpacing: 7,
        categoryFont: .system(size: 18).bold(),
        systemFont: .system(size: 18))
    
    /**
     The style to use for standard iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPadLandscape = EmojiKeyboardStyle(
        rows: 5,
        itemSize: 60,
        itemFont: .system(size: 50),
        horizontalItemSpacing: 15,
        verticalItemSpacing: 10,
        verticalCategoryStackSpacing: 7,
        categoryFont: .system(size: 18).bold(),
        systemFont: .system(size: 18))
    
    /**
     The style to use for standard iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPadPortrait = EmojiKeyboardStyle(
        rows: 3,
        itemSize: 60,
        itemFont: .system(size: 45),
        horizontalItemSpacing: 15,
        verticalItemSpacing: 10,
        verticalCategoryStackSpacing: 5,
        categoryFont: .system(size: 18).bold(),
        systemFont: .system(size: 18))
    
    /**
     The style to use for iPhones in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPhoneLandscape = EmojiKeyboardStyle(
        rows: 3)
    
    /**
     The style to use for iPhones in portrait.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPhonePortrait = EmojiKeyboardStyle()

    /**
     Get the standard style to use for a certain context.

     - Parameters:
       - context: The context to base the style on.
     */
    static func standard(
        for context: KeyboardContext
    ) -> EmojiKeyboardStyle {
        switch context.deviceType {
        case .mac: return .standardPhonePortrait
        case .phone: return standardPhone(for: context)
        case .pad: return standardPad(for: context)
        case .tv: return .standardPhonePortrait
        case .watch: return .standardPhonePortrait
        case .other: return .standardPhonePortrait
        }
    }

    /**
     Get the standard style to use for a certain context.

     - Parameters:
       - context: The context to base the style on.
     */
    static func standardPad(
        for context: KeyboardContext
    ) -> EmojiKeyboardStyle {
        let isPortrait = context.interfaceOrientation.isPortrait
        let isLargePad = context.screenSize.isScreenSize(.iPadProLargeScreenPortrait)
        if isLargePad {
            return isPortrait ? .standardLargePadPortrait : .standardLargePadLandscape
        }
        return isPortrait ? .standardPadPortrait : .standardPadLandscape
    }

    /**
     Get the standard style to use for a certain context.

     - Parameters:
       - context: The context to base the style on.
     */
    static func standardPhone(
        for context: KeyboardContext
    ) -> EmojiKeyboardStyle {
        let isPortrait = context.interfaceOrientation.isPortrait
        return isPortrait ? .standardPhonePortrait : .standardPhoneLandscape
    }
}
