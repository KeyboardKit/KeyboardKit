//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardAction {
    
    /**
     The standard action, if any, that should be executed on
     an input view controller, when this action is triggered
     with a double-tap.
     */
    var standardDoubleTapAction: GestureAction? {
        switch self {
        case .space: return endSentenceAction
        case .shift(let currentState):
            if currentState != .lowercased { return nil }
            return { $0?.changeKeyboardType(to: .alphabetic(.capsLocked)) }
        default: return nil
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     an input view controller, when this action is triggered
     with a long press.
     */
    var standardLongPressAction: GestureAction? {
        switch self {
        case .shift: return { $0?.changeKeyboardType(to: .alphabetic(.capsLocked)) }
        default: return standardTapAction
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     an input view controller, when this action is triggered
     with a press and hold.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     an input view controller or a text document proxy, when
     this action is triggered with a tap.
     */
    var standardTapAction: GestureAction? {
        if let action = standardTapActionForController { return action }
        if let action = standardTapActionForProxy { return { action($0?.textDocumentProxy) } }
        return nil
    }
    
    /**
     The standard action, if any, that should be executed on
     an input view controller, when this action is triggered
     with a tap.
     */
    var standardTapActionForController: InputViewControllerAction? {
        switch self {
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .keyboardType(let type): return { $0?.changeKeyboardType(to: type) }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased: $0?.changeKeyboardType(to: .alphabetic(.uppercased), after: .milliseconds(200))
            case .uppercased: $0?.changeKeyboardType(to: .alphabetic(.lowercased))
            case .capsLocked: $0?.changeKeyboardType(to: .alphabetic(.lowercased))
            }}
        default: return nil
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     a text document proxy when the action is triggered with
     a tap.
     */
    var standardTapActionForProxy: TextDocumentProxyAction? {
        switch self {
        case .backspace: return { $0?.deleteBackward() }
        case .character(let char): return { $0?.insertText(char) }
        case .emoji(let char): return { $0?.insertText(char) }
        case .moveCursorBackward: return { $0?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.adjustTextPosition(byCharacterOffset: 1) }
        case .newLine: return { $0?.insertText("\n") }
        case .space: return { $0?.insertText(" ") }
        case .tab: return { $0?.insertText("\t") }
        default: return nil
        }
    }
}
