//
//  KeyboardStyle+Emojis.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import Foundation
import SwiftUI

@available(*, deprecated, renamed: "EmojiKeyboardStyle")
public extension KeyboardStyle {
    
    struct EmojiKeyboard {
        
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

@available(*, deprecated, renamed: "EmojiKeyboardStyle")
public extension KeyboardStyle.EmojiKeyboard {
    
    static func standard(
        for context: KeyboardContext
    ) -> KeyboardStyle.EmojiKeyboard {
        switch context.deviceType {
        case .mac: .standardPhonePortrait
        case .phone: standardPhone(for: context)
        case .pad: standardPad(for: context)
        case .tv: .standardPhonePortrait
        case .watch: .standardPhonePortrait
        case .vision: .standardPhonePortrait
        case .other: .standardPhonePortrait
        }
    }

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
    
    static var standardLargePad = standardLargePadPortrait

    static var standardLargePadLandscape = standardPad(
        rows: 6,
        horizontalItemSpacing: 10,
        verticalCategoryStackSpacing: 10,
        categoryTitlePadding: .init(top: 18, leading: 0, bottom: 0, trailing: 0)
    )
    
    static var standardLargePadPortrait = standardPad(
        rows: 5,
        itemSize: 55,
        horizontalItemSpacing: 10,
        verticalCategoryStackSpacing: 7,
        categoryTitleFont: .system(size: 16).bold(),
        categoryTitlePadding: .init(top: 14, leading: 0, bottom: 0, trailing: 0)
    )
    
    static var standardPad = standardPadPortrait
    
    static var standardPadLandscape = standardPad(
        rows: 5,
        itemSize: 58,
        horizontalItemSpacing: 15,
        verticalCategoryStackSpacing: 7
    )
    
    static var standardPadPortrait = standardPad(
        rows: 3,
        itemSize: 67,
        horizontalItemSpacing: 15,
        verticalCategoryStackSpacing: 5
    )
    
    static var standardPhone = standardPhonePortrait
    
    static var standardPhoneLandscape = KeyboardStyle.EmojiKeyboard(
        rows: 3
    )
    
    static var standardPhonePortrait = KeyboardStyle.EmojiKeyboard()
}
