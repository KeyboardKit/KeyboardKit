//
//  KeyboardAction+System.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 The "system" extensions are just suggestions if you want to
 mimic system keyboards. You do not have to use them in your
 custom keyboards.
 */
public extension KeyboardAction {
    
    /**
     The font that would be used in a system keyboard.
     
     For actions that don't exist on a system level, this is
     just a suggestion, that you can ignore or override.
     */
    var systemFont: UIFont {
        .preferredFont(forTextStyle: systemTextStyle)
    }
    
    /**
     The text that should be used by system keyboard buttons
     that performs this action.
     */
    var systemKeyboardButtonText: String? {
        switch self {
        case .character(let char): return char
        case .emoji(let emoji): return emoji
        case .emojiCategory(let cat): return cat.fallbackDisplayEmoji
        case .keyboardType(let type): return type.systemKeyboardButtonText
        default: return nil
        }
    }
    
    /**
     The text style that would be used in a system keyboard.
     
     For actions that don't exist on a system level, this is
     just a suggestion, that you can ignore or override.
    */
    var systemTextStyle: UIFont.TextStyle {
        if hasMultiCharSystemKeyboardButtonText { return .body }
        switch self {
        case .emoji: return .title1
        case .emojiCategory: return .callout
        default: return .title2
        }
    }
}

private extension KeyboardAction {
    
    /**
     Whether or not the system button text contains multiple
     characters.
     */
    var hasMultiCharSystemKeyboardButtonText: Bool {
        guard let text = systemKeyboardButtonText else { return false }
        return text.count > 1
    }
}
