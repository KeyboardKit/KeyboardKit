//
//  KeyboardStyle+Emojis.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Foundation
import SwiftUI

public extension KeyboardStyle {
    
    /**
     This style can be used to style emoji keyboards, like a
     Pro **EmojiKeyboard** and other emoji views.
     
     The style can customize the font, spacing, etc. of both
     keyboards, grids, callouts, etc.
     
     Note that the style has both an ``itemSize`` as well as
     an ``itemFont`` parameter. SwiftUI grids use ``itemSize``
     as pre-calculated cell size, then apply ``itemFont`` to
     each grid item. Make sure to find a good combo when you
     customize these values.
     */
    struct EmojiKeyboard {
        
        /**
         Create an emoji keyboard item style.
         
         The standard parameter values aim to create a style
         that mimics a standard iOS emoji portrait keyboard.
         
         - Parameters:
           - rows: The number of rows to use in the keyboard, by default `5`.
           - itemSize: The emoji item size to use, by default `40`.
           - itemFont: The font to apply to emojis, by default `.system(size: 33)`.
           - horizontalItemSpacing: The horizontal spacing to use between emojis, by default `10`.
           - verticalItemSpacing: The vertical spacing to use between emojis, by default `6`.
           - verticalCategoryStackSpacing: The vertical spacing to apply to the vertical category keyboard stack, by default `0`.
           - categoryTitleFont: The font to apply to the category title label, by default `.system(size: 12)`.
           - categoryTitlePadding: The top and bottom padding to apply to the category title label, by default `2` and `5` for top and bottom.
           - categoryEmojiFont: The font to apply to the category emoji label, by default `.system(size: 14)`.
           - abcText: The text to use for the ABC button, by default `ABC`.
           - abcFont: The font to apply to the ABC button, by default `.system(size: 14)`.
           - backspaceIcon: The icon to use for the backspace button, by default `.keyboardBackspace`.
           - backspaceFont: The font to apply to the backspace button, by default `.system(size: 16)`.
           - selectedCategoryColor: The color to apply to the selected badge, by default `.primary.opacity(0.1)`.
         */
        public init(
            rows: Int = 5,
            itemSize: Double = 40,
            itemFont: Font = .system(size: 33),
            horizontalItemSpacing: Double = 10,
            verticalItemSpacing: Double = 6,
            verticalCategoryStackSpacing: Double = 0,
            categoryTitleFont: Font = .system(size: 12),
            categoryTitlePadding: EdgeInsets = .init(top: 2, leading: 0, bottom: 5, trailing: 0),
            categoryEmojiFont: Font = .system(size: 14),
            abcText: String = "ABC",
            abcFont: Font = .system(size: 14),
            backspaceIcon: Image = .keyboardBackspace,
            backspaceFont: Font = .system(size: 20),
            selectedCategoryColor: Color = .primary.opacity(0.1)
        ) {
            self.itemSize = itemSize
            self.itemFont = itemFont
            self.categoryTitleFont = categoryTitleFont
            self.categoryTitlePadding = categoryTitlePadding
            self.categoryEmojiFont = categoryEmojiFont
            self.abcFont = abcFont
            self.backspaceFont = backspaceFont
            self.rows = rows
            self.horizontalItemSpacing = horizontalItemSpacing
            self.verticalItemSpacing = verticalItemSpacing
            self.verticalCategoryStackSpacing = verticalCategoryStackSpacing
            self.selectedCategoryColor = selectedCategoryColor
            self.abcText = abcText
            self.backspaceIcon = backspaceIcon
        }
        
        /// The text to use for the ABC button.
        public var abcText: String
        
        /// The icon to use for the backspace button.
        public var backspaceIcon: Image
        
        /// The font to apply to the category title label.
        public var categoryTitleFont: Font
        
        /// The padding to apply to the category title label.
        public var categoryTitlePadding: EdgeInsets
        
        /// The font to apply to the category emoji labels.
        public var categoryEmojiFont: Font
        
        /// The horizontal spacing to use.
        public var horizontalItemSpacing: Double
        
        /// Double font to apply to the emojis.
        public var itemFont: Font
        
        /// The item size to use.
        public var itemSize: Double
        
        /// Double number of rows to use in the keyboard.
        public var rows: Int
        
        /// The color to apply to the selected badge.
        public var selectedCategoryColor: Color
        
        /// The font to apply to the ABC button.
        public var abcFont: Font
        
        /// The font to apply to the backspace button.
        public var backspaceFont: Font
        
        /// The total keyboard height.
        public var totalHeight: Double { Double(rows) * itemSize }
        
        /// The vertical category spacing to use.
        public var verticalCategoryStackSpacing: CGFloat
        
        /// The vertical spacing to use.
        public var verticalItemSpacing: CGFloat
    }
}

public extension KeyboardStyle.EmojiKeyboard {

    static func standardPad(
        rows: Int,
        itemSize: Double = 60,
        horizontalItemSpacing: Double,
        verticalCategoryStackSpacing: Double,
        categoryTitleFont: Font = .system(size: 18).bold(),
        categoryTitlePadding: EdgeInsets = .init(top: 18, leading: 0, bottom: 7, trailing: 0)
    ) -> KeyboardStyle.EmojiKeyboard {
        .init(
            rows: rows,
            itemSize: itemSize,
            itemFont: .system(size: 48),
            horizontalItemSpacing: horizontalItemSpacing,
            verticalCategoryStackSpacing: verticalCategoryStackSpacing,
            categoryTitleFont: categoryTitleFont,
            categoryTitlePadding: categoryTitlePadding,
            categoryEmojiFont: .system(size: 35).bold(),
            abcFont: .system(size: 18),
            backspaceFont: .system(size: 25)
        )
    }

    /**
     The style to use for large iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardLargePadLandscape = standardPad(
        rows: 6,
        horizontalItemSpacing: 10,
        verticalCategoryStackSpacing: 10,
        categoryTitlePadding: .init(top: 18, leading: 0, bottom: 0, trailing: 0)
    )
    
    /**
     The style to use for large iPads in portrait.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardLargePadPortrait = standardPad(
        rows: 5,
        itemSize: 55,
        horizontalItemSpacing: 10,
        verticalCategoryStackSpacing: 7,
        categoryTitleFont: .system(size: 16).bold(),
        categoryTitlePadding: .init(top: 14, leading: 0, bottom: 0, trailing: 0)
    )
    
    /**
     The style to use for standard iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPadLandscape = standardPad(
        rows: 5,
        itemSize: 58,
        horizontalItemSpacing: 15,
        verticalCategoryStackSpacing: 7
    )
    
    /**
     The style to use for standard iPads in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPadPortrait = standardPad(
        rows: 3,
        itemSize: 67,
        horizontalItemSpacing: 15,
        verticalCategoryStackSpacing: 5
    )
    
    /**
     The style to use for iPhones in landscape.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPhoneLandscape = KeyboardStyle.EmojiKeyboard(
        rows: 3
    )
    
    /**
     The style to use for iPhones in portrait.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPhonePortrait = KeyboardStyle.EmojiKeyboard()

    /**
     Get the standard style to use for a certain context.

     - Parameters:
       - context: The context to base the style on.
     */
    static func standard(
        for context: KeyboardContext
    ) -> KeyboardStyle.EmojiKeyboard {
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
    ) -> KeyboardStyle.EmojiKeyboard {
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
    ) -> KeyboardStyle.EmojiKeyboard {
        let isPortrait = context.interfaceOrientation.isPortrait
        return isPortrait ? .standardPhonePortrait : .standardPhoneLandscape
    }
}
