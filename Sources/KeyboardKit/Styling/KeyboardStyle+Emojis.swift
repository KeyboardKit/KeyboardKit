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
           - verticalPadding: The vertical padding of the keyboard, by default `5`.
           - verticalItemSpacing: The vertical spacing to use between emojis, by default `6`.
           - verticalCategoryStackSpacing: The vertical spacing to apply to the vertical category keyboard stack, by default `0`.
           - categoryTitleFont: The font to apply to the category title label, by default `.system(size: 12)`.
           - categoryTitlePadding: The top and bottom padding to apply to the category title label, by default `2` and `5` for top and bottom.
           - menuAbcText: The text to use for the menu ABC button, by default `ABC`.
           - menuAbcFont: The font to apply to the menu ABC button, by default `.system(size: 14)`.
           - menuIconSize: The size to apply to the menu category icons, by default `15`.
           - menuIconSpacing: The spacing to apply between menu category icons, by default `5`.
           - menuIconSelectionSize: The size of the selection outside of the icon, by default `6`.
           - menuBackspaceIcon: The icon to use for the menu backspace button, by default `.keyboardBackspace`.
           - menuBackspaceFont: The font to apply to the menu backspace button, by default `.system(size: 16)`.
           - selectedCategoryColor: The color to apply to the selected category, by default `.primary.opacity(0.1)`.
         */
        public init(
            rows: Int = 5,
            itemSize: Double = 40,
            itemFont: Font = .system(size: 33),
            horizontalItemSpacing: Double = 10,
            verticalPadding: Double = 5,
            verticalItemSpacing: Double = 6,
            verticalCategoryStackSpacing: Double = 0,
            categoryTitleFont: Font = .system(size: 12),
            categoryTitlePadding: EdgeInsets = .init(top: 2, leading: 0, bottom: 5, trailing: 0),
            menuAbcFont: Font = .system(size: 14),
            menuIconSize: CGFloat = 15,
            menuIconSpacing: CGFloat = 5,
            menuIconSelectionSize: CGFloat = 6,
            menuBackspaceFont: Font = .system(size: 20, weight: .light),
            menuSelectionColor: Color = .primary.opacity(0.1)
        ) {
            self.rows = rows
            self.itemSize = itemSize
            self.itemFont = itemFont
            self.horizontalItemSpacing = horizontalItemSpacing
            self.verticalPadding = verticalPadding
            self.verticalItemSpacing = verticalItemSpacing
            self.verticalCategoryStackSpacing = verticalCategoryStackSpacing
            self.categoryTitleFont = categoryTitleFont
            self.categoryTitlePadding = categoryTitlePadding
            self.menuAbcFont = menuAbcFont
            self.menuIconSize = menuIconSize
            self.menuIconSpacing = menuIconSpacing
            self.menuIconSelectionSize = menuIconSelectionSize
            self.menuBackspaceFont = menuBackspaceFont
            self.menuSelectionColor = menuSelectionColor
        }
        
        
        /// The font to apply to the category title label.
        public var categoryTitleFont: Font
        
        /// The padding to apply to the category title label.
        public var categoryTitlePadding: EdgeInsets
        
        /// The horizontal spacing to use.
        public var horizontalItemSpacing: Double
        
        /// Double font to apply to the emojis.
        public var itemFont: Font
        
        /// The item size to use.
        public var itemSize: Double
        
        /// Double number of rows to use in the keyboard.
        public var rows: Int
        
        /// The font to apply to the menu ABC button.
        public var menuAbcFont: Font
        
        /// The size to apply to the menu category icons.
        public var menuIconSize: Double
        
        /// The spacing to apply between menu category icons.
        public var menuIconSpacing: Double
        
        /// The size of the selection outside of the icon.
        public var menuIconSelectionSize: Double
        
        /// The font to apply to the menu backspace button.
        public var menuBackspaceFont: Font
        
        /// The color to apply to the selected category.
        public var menuSelectionColor: Color
        
        /// The total keyboard height.
        public var totalHeight: Double { Double(rows) * itemSize }
        
        /// The vertical padding of the keyboard.
        public var verticalPadding: CGFloat
        
        /// The vertical category spacing to use.
        public var verticalCategoryStackSpacing: CGFloat
        
        /// The vertical spacing to use.
        public var verticalItemSpacing: CGFloat
    }
}

public extension KeyboardStyle.EmojiKeyboard {
    
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
            menuAbcFont: .system(size: 18),
            menuIconSize: 31,
            menuIconSpacing: 1,
            menuIconSelectionSize: 10,
            menuBackspaceFont: .system(size: 25)
            
        )
    }
    
    /**
     The style to use for large iPads.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardLargePad = standardLargePadPortrait

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
     The style to use for standard iPads.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPad = standardPadPortrait
    
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
     The style to use for iPhones.
     
     This property can be changed to change the global style
     of all emoji keyboards in this configuration.
     */
    static var standardPhone = standardPhonePortrait
    
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
}
