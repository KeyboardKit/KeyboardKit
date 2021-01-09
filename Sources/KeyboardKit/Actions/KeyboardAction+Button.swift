//
//  KeyboardAction+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension KeyboardAction {
    
    /**
     The standard button font in a system keyboard.
     */
    var standardButtonFont: UIFont {
        .preferredFont(forTextStyle: standardButtonTextStyle)
    }
    
    /**
     The standard button text in a system keyboard.
     */
    var standardButtonText: String? {
        switch self {
        case .character(let char): return char
        case .emoji(let emoji): return emoji
        case .emojiCategory(let cat): return cat.fallbackDisplayEmoji
        case .keyboardType(let type): return type.standardButtonText
        default: return nil
        }
    }
    
    /**
     The standard button text style in a system keyboard.
    */
    var standardButtonTextStyle: UIFont.TextStyle {
        if hasMultiCharButtonText { return .body }
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
    var hasMultiCharButtonText: Bool {
        guard let text = standardButtonText else { return false }
        return text.count > 1
    }
}
