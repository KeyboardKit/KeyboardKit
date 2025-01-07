//
//  KeyboardAction+Accessibility.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /// The action's accessibility label.
    var accessibilityLabel: String? {
        switch self {
        case .backspace: "Backspace"
        case .capsLock: "Capslock"
        case .character(let char): char
        case .characterMargin: nil
        case .command: "Command"
        case .control: "Control"
        case .custom(let name): name
        case .diacritic(let val): val.char
        case .dictation: "Dictation"
        case .dismissKeyboard: "Dismiss Keyboard"
        case .emoji(let emoji): "Emoji - \(emoji)"
        case .escape: "Escape"
        case .function: "Function"
        case .image(let desc, _, _): desc
        case .keyboardType(let keyboardType): "Keyboard Type - \(keyboardType.id)"
        case .moveCursorBackward: "Move Cursor Backward"
        case .moveCursorForward: "Move Cursor Forward"
        case .nextKeyboard: "Next Keyboard"
        case .nextLocale: "Next Locale"
        case .none: nil
        case .option: "Option"
        case .primary(let returnKeyType): returnKeyType.id
        case .settings: "Settings"
        case .shift: "Shift"
        case .space: KKL10n.space.text
        case .systemImage(let desc, _, _): desc
        case .systemSettings: "System Settings"
        case .tab: "Tab"
        case .text(let text): text
        case .url(let url, _): "Open \(url?.absoluteString ?? "invalid url")"
        }
    }
}
