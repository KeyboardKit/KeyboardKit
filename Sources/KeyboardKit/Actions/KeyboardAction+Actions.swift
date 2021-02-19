//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This extension defines standard actions for various actions.
 
 You can trigger these actions directly, but a more flexible
 way is to use an action handler.
 */
public extension KeyboardAction {
    
    
    // MARK: - Types
    
    typealias GestureAction = (KeyboardInputViewController?) -> Void
    
    /**
     The action that by default should be triggered when the
     keyboard action is double tapped.
     */
    var standardDoubleTapAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     keyboard action is long pressed.
     */
    var standardLongPressAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     keyboard action is pressed down.
     */
    var standardPressAction: GestureAction? {
        switch self {
        case .keyboardType(let type): return { $0?.changeKeyboardType(to: type) }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     keyboard action is released.
     */
    var standardReleaseAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     keyboard action pressed and hold.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     keyboard action is tapped.
     */
    var standardTapAction: GestureAction? {
        if self.isPrimaryAction { return { $0?.textDocumentProxy.insertText("\n") }}
        
        switch self {
        case .backspace: return { $0?.textDocumentProxy.deleteBackward() }
        case .character(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .emoji(let emoji): return { $0?.textDocumentProxy.insertText(emoji.char) }
        case .moveCursorBackward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1) }
        case .nextLocale: return { $0?.keyboardContext.selectNextLocale() }
        case .newLine: return { $0?.textDocumentProxy.insertText("\n") }
        case .return: return { $0?.textDocumentProxy.insertText("\n") }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased, .neutral: $0?.changeKeyboardType(to: .alphabetic(.uppercased))
            case .uppercased, .capsLocked: $0?.changeKeyboardType(to: .alphabetic(.lowercased))
            }
        }
        case .space: return { $0?.textDocumentProxy.insertText(" ") }
        case .tab: return { $0?.textDocumentProxy.insertText("\t") }
        default: return nil
        }
    }
}
