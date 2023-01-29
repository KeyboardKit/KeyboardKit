//
//  KeyboardAction+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import SwiftUI

public extension KeyboardAction {
    
    /**
     The action's standard button image.
     */
    func standardButtonImage(for context: KeyboardContext) -> Image? {
        if let image = standardButtonTextImageReplacement(for: context) { return image }
        
        switch self {
        case .backspace: return .keyboardBackspace(for: context.locale)
        case .command: return .keyboardCommand
        case .control: return .keyboardControl
        case .dictation: return .keyboardDictation
        case .dismissKeyboard: return .keyboardDismiss
        case .image(_, let imageName, _): return Image(imageName)
        case .keyboardType(let type): return type.standardButtonImage
        case .moveCursorBackward: return .keyboardLeft
        case .moveCursorForward: return .keyboardRight
        case .nextKeyboard: return .keyboardGlobe
        case .option: return .keyboardOption
        case .primary(let type): return type.standardButtonImage(for: context.locale)
        case .settings: return .keyboardSettings
        case .shift(let currentCasing): return currentCasing.standardButtonImage
        case .systemImage(_, let imageName, _): return Image(systemName: imageName)
        case .tab: return .keyboardTab
        default: return nil
        }
    }
    
    /**
     The action's standard button text.
     */
    func standardButtonText(for context: KeyboardContext) -> String? {
        switch self {
        case .character(let char): return standardButtonText(for: char)
        case .emoji(let emoji): return emoji.char
        case .emojiCategory(let cat): return cat.fallbackDisplayEmoji.char
        case .keyboardType(let type): return type.standardButtonText(for: context)
        case .nextLocale: return context.locale.languageCode?.uppercased()
        case .primary(let type): return type.standardButtonText(for: context.locale)
        case .space: return KKL10n.space.text(for: context)
        default: return nil
        }
    }
    
    /**
     The action's standard button text image replacement, if
     the text represents an image asset.
     */
    func standardButtonTextImageReplacement(for context: KeyboardContext) -> Image? {
        switch standardButtonText(for: context) {
        case "↵", "↳": return .keyboardNewline(for: context.locale)
        default: return nil
        }
    }
}

private extension KeyboardAction {
    
    func standardButtonText(for char: String) -> String {
        switch char {
        case .zeroWidthSpace: return "⁞"
        default: return char
        }
    }
}
