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
     action is triggered without a certain gesture.
     */
    var standardAction: GestureAction? {
        standardReleaseAction ?? standardPressAction
    }
    
    /**
     The action that by default should be triggered when the
     action is triggered with a certain gesture.
     */
    func standardAction(for gesture: Gestures.KeyboardGesture) -> GestureAction? {
        switch gesture {
        case .doubleTap: standardDoubleTapAction
        case .longPress: standardLongPressAction
        case .press: standardPressAction
        case .release: standardReleaseAction
        case .repeatPress: standardRepeatAction
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
        case .space: { _ in }
        default: nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is pressed.
     */
    var standardPressAction: GestureAction? {
        switch self {
        case .backspace: { $0?.deleteBackward() }
        case .capsLock: Keyboard.Case.capsLocked.standardPressAction
        case .keyboardType(let type): { $0?.setKeyboardType(type) }
        case .shift(let currentCase): currentCase.standardPressAction
        default: nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is released.
     */
    var standardReleaseAction: GestureAction? {
        switch self {
        case .capsLock: Keyboard.Case.capsLocked.standardPressAction
        case .character(let char): { $0?.insertText(char) }
        case .characterMargin(let char): { $0?.insertText(char) }
        case .dictation: { $0?.performDictation() }
        case .dismissKeyboard: { $0?.dismissKeyboard() }
        case .emoji(let emoji): { $0?.insertText(emoji.char) }
        case .moveCursorBackward: { $0?.adjustTextPosition(by: -1) }
        case .moveCursorForward: { $0?.adjustTextPosition(by: 1) }
        case .nextLocale: { $0?.selectNextLocale() }
        case .primary: { $0?.insertText(.newline) }
        case .shift(let current): current.standardReleaseAction
        case .space: { $0?.insertText(.space) }
        case .systemSettings: { $0?.openUrl(.keyboardSettings) }
        case .tab: { $0?.insertText(.tab) }
        case .url(let url, _): { $0?.openUrl(url) }
        default: nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is pressed, and repeated until it is released.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: standardPressAction
        default: nil
        }
    }
}
