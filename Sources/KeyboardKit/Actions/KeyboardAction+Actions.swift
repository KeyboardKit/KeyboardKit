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
     keyboard action is triggered with a double tap.
     */
    var standardDoubleTapAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     keyboard action is triggered with a long press.
     */
    var standardLongPressAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     keyboard action is triggered by pressing and holding.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     keyboard action is triggered with a tap.
     */
    var standardTapAction: GestureAction? {
        if self.isPrimaryAction { return { $0?.textDocumentProxy.insertText("\n") }}
        
        switch self {
        case .backspace: return { $0?.textDocumentProxy.deleteBackward() }
        case .character(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .emoji(let emoji): return { $0?.textDocumentProxy.insertText(emoji.char) }
        case .keyboardType(let type): return { $0?.changeKeyboardType(to: type) }
        case .moveCursorBackward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1) }
        case .newLine: return { $0?.textDocumentProxy.insertText("\n") }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased: $0?.changeKeyboardType(to: .alphabetic(.uppercased))
            case .uppercased: $0?.changeKeyboardType(to: .alphabetic(.lowercased))
            case .capsLocked: $0?.changeKeyboardType(to: .alphabetic(.lowercased))
            }}
        case .space: return { $0?.textDocumentProxy.insertText(" ") }
        case .tab: return { $0?.textDocumentProxy.insertText("\t") }
        default: return nil
        }
    }
}
