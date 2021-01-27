//
//  KeyboardAction+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

public extension KeyboardAction {
    
    /**
     The standard button background in a system keyboard.
     */
    func standardButtonBackgroundColor(for context: KeyboardContext) -> Color {
        if case .none = self { return .clear }
        if case .emoji = self { return .clearInteractable }
        if case .emojiCategory = self { return .clearInteractable }
        if isSystemAction { return .standardDarkButton(for: context) }
        return .standardButton(for: context)
    }
    
    /**
     The standard button font in a system keyboard.
     */
    var standardButtonFont: Font {
        if let style = standardButtonTextStyle {
            return .system(style)
        }
        return .system(size: 22)
    }
    
    /**
     The standard button image in a system keyboard.
     */
    func standardButtonImage(for context: KeyboardContext) -> Image? {
        switch self {
        case .backspace: return .backspace
        case .command: return .command
        case .control: return .control
        case .dictation: return .dictation
        case .dismissKeyboard: return .keyboardDismiss
        case .image(_, let imageName, _): return Image(imageName)
        case .keyboardType(let type): return type.standardButtonImage
        case .moveCursorBackward: return .moveCursorLeft
        case .moveCursorForward: return .moveCursorRight
        case .newLine: return .newLine
        case .nextKeyboard: return .globe
        case .option: return .option
        case .shift(let currentState): return currentState.standardButtonImage
        case .systemImage(_, let imageName, _): return Image(systemName: imageName)
        case .tab: return .tab
        default: return nil
        }
    }
    
    /**
     The standard button shadow color in a system keyboard.
     */
    func standardButtonShadowColor(for context: KeyboardContext) -> Color {
        if case .none = self { return .clear }
        if case .emoji = self { return .clear }
        return .standardButtonShadowColor(for: context)
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
    var standardButtonTextStyle: Font.TextStyle? {
        if hasMultiCharButtonText { return .body }
        switch self {
        case .emoji: return .title
        case .emojiCategory: return .callout
        default:
            if #available(iOS 14.0, *) {
                return .title2
            } else {
                return nil
            }
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
