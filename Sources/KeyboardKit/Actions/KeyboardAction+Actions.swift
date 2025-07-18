//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This extension defines standard gestures for the various
/// keyboard actions.
///
/// The ``KeyboardAction/GestureAction`` typealias signature
/// uses an optional ``KeyboardController`` since some types
/// will use this with a weak controller reference.
public extension KeyboardAction {
    
    /// This typealias defines a controller gesture action.
    typealias GestureAction = (KeyboardController?) -> Void

    /// The standard controller action.
    var standardAction: GestureAction? {
        standardReleaseAction ?? standardPressAction
    }

    /// The standard controller action for a certain gesture.
    func standardAction(for gesture: Keyboard.Gesture) -> GestureAction? {
        switch gesture {
        case .doubleTap: standardDoubleTapAction
        case .longPress: standardLongPressAction
        case .press: standardPressAction
        case .release: standardReleaseAction
        case .repeatPress: standardRepeatAction
        case .end: nil
        }
    }

    /// The standard double tap action, if any.
    var standardDoubleTapAction: GestureAction? { nil }

    /// The standard long press action, if any.
    var standardLongPressAction: GestureAction? {
        switch self {
        case .space: { _ in }
        default: nil
        }
    }

    /// The standard press action, if any.
    var standardPressAction: GestureAction? {
        switch self {
        case .backspace: { $0?.deleteBackward() }
        case .capsLock: { $0?.setKeyboardCase(.capsLocked) }
        case .keyboardType(let type): { $0?.setKeyboardType(type) }
        default: nil
        }
    }

    /// The standard release action, if any.
    var standardReleaseAction: GestureAction? {
        switch self {
        case .character(let char): { $0?.insertText(char) }
        case .characterMargin(let char): { $0?.insertText(char) }
        case .diacritic(let dia): { $0?.insertDiacritic(dia) }
        case .dictation: { $0?.performDictation() }
        case .dismissKeyboard: { $0?.dismissKeyboard() }
        case .emoji(let emoji): { $0?.insertText(emoji.char) }
        case .moveCursorBackward: { $0?.adjustTextPosition(by: -1) }
        case .moveCursorForward: { $0?.adjustTextPosition(by: 1) }
        case .nextLocale: { $0?.selectNextLocale() }
        case .primary: { $0?.insertText(.newline) }
        case .shift: { $0?.state.keyboardContext.keyboardCase.standardReleaseAction?($0) }
        case .space: { $0?.insertText(.space) }
        case .systemSettings: { $0?.openUrl(.systemSettings) }
        case .tab: { $0?.insertText(.tab) }
        case .text(let text): { $0?.insertText(text) }
        case .url(let url, _): { $0?.openUrl(url) }
        case .urlDomain: { $0?.insertText(".") }
        default: nil
        }
    }

    /// The standard repeat action, if any.
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: standardPressAction
        default: nil
        }
    }
}
