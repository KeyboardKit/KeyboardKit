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
     The action's standard keyboard button background color.
     */
    func standardButtonBackgroundColor(for context: KeyboardContext) -> Color {
        if case .none = self { return .clear }
        if case .emoji = self { return .clearInteractable }
        if case .emojiCategory = self { return .clearInteractable }
        if isSystemAction { return .standardDarkButton(for: context) }
        return .standardButton(for: context)
    }
    
    /**
     The action's standard keyboard button font.
     */
    var standardButtonFont: UIFont {
        .preferredFont(forTextStyle: standardButtonTextStyle)
    }
    
    /**
     The action's standard keyboard button image.
     */
    var standardButtonImage: Image? {
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
     The action's standard keyboard button shadow color.
     */
    func standardButtonShadowColor(for context: KeyboardContext) -> Color {
        if case .none = self { return .clear }
        if case .emoji = self { return .clear }
        return .standardButtonShadowColor(for: context)
    }

    /**
     The action's standard keyboard button text.
     */
    var standardButtonText: String? {
        switch self {
        case .character(let char): return char
        case .emoji(let emoji): return emoji.char
        case .emojiCategory(let cat): return cat.fallbackDisplayEmoji.char
        case .keyboardType(let type): return type.standardButtonText
        default: return nil
        }
    }
    
    /**
     The action's standard keyboard button text style.
    */
    var standardButtonTextStyle: UIFont.TextStyle {
        if hasMultiCharButtonText { return .body }
        switch self {
        case .emoji: return .title1
        case .emojiCategory: return .callout
        case .space: return .body
        default: return .title2
        }
    }
}

private extension KeyboardAction {
    
    /**
     Whether or not the button text has multiple characters.
     */
    var hasMultiCharButtonText: Bool {
        guard let text = standardButtonText else { return false }
        return text.count > 1
    }
}
