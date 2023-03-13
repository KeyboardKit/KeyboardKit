//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This extension defines standard gesture actions for various
 keyboard actions and ``KeyboardInputViewController``s.

 The ``KeyboardAction/GestureAction`` typealias signature is
 using an optional ``KeyboardController`` since some classes
 will use this with a weak controller reference.
 */
public extension KeyboardAction {
    
    /**
     This typealias represents a gesture action that affects
     the provided ``KeyboardController``.
     */
    typealias GestureAction = (KeyboardController?) -> Void
    
    /**
     The action that by default should be triggered when the
     action is triggered with a certain ``KeyboardGesture``.
     */
    func standardAction(for gesture: KeyboardGesture) -> GestureAction? {
        switch gesture {
        case .doubleTap: return standardDoubleTapAction
        case .longPress: return standardLongPressAction
        case .press: return standardPressAction
        case .release: return standardReleaseAction
        case .repeatPress: return standardRepeatAction
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is double tapped.
     */
    var standardDoubleTapAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     action is long pressed.
     */
    var standardLongPressAction: GestureAction? {
        switch self {
        case .space: return { _ in }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is pressed.
     */
    var standardPressAction: GestureAction? {
        switch self {
        case .backspace: return { $0?.deleteBackward() }
        case .keyboardType(let type): return { $0?.setKeyboardType(type) }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is released.
     */
    var standardReleaseAction: GestureAction? {
        switch self {
        case .character(let char): return { $0?.insertText(char) }
        case .characterMargin(let char): return { $0?.insertText(char) }
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .emoji(let emoji): return { $0?.insertText(emoji.char) }
        case .moveCursorBackward: return { $0?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.adjustTextPosition(byCharacterOffset: 1) }
        case .nextLocale: return { $0?.selectNextLocale() }
        case .nextKeyboard: return { $0?.selectNextKeyboard() }
        case .primary: return { $0?.insertText(.newline) }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased: $0?.setKeyboardType(.alphabetic(.uppercased))
            case .auto, .capsLocked, .uppercased: $0?.setKeyboardType(.alphabetic(.lowercased))
            }
        }
        case .space: return { $0?.insertText(.space) }
        case .tab: return { $0?.insertText(.tab) }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is pressed, and repeated until it is released.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardPressAction
        default: return nil
        }
    }
}
