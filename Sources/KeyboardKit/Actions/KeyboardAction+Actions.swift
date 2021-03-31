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
     action is double tapped.
     */
    var standardDoubleTapAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     action is long pressed.
     */
    var standardLongPressAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is pressed.
     */
    var standardPressAction: GestureAction? {
        switch self {
        case .keyboardType(let type): return { $0?.keyboardContext.keyboardType = type }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is released.
     */
    var standardReleaseAction: GestureAction? { nil }
    
    /**
     The action that by default should be triggered when the
     action is pressed, until it's released.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardTapAction
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is tapped.
     */
    var standardTapAction: GestureAction? {
        if let action = standardTextDocumentProxyAction { return action }
        
        switch self {
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .nextLocale: return { $0?.keyboardContext.selectNextLocale() }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased, .neutral: $0?.keyboardContext.keyboardType = .alphabetic(.uppercased)
            case .uppercased, .capsLocked: $0?.keyboardContext.keyboardType = .alphabetic(.lowercased)
            }
        }
        default: return nil
        }
    }
    
    /**
     The standard text document proxy action, if any.
     */
    var standardTextDocumentProxyAction: GestureAction? {
        if let action = standardTextDocumentProxyInputAction { return action }
        
        switch self {
        case .moveCursorBackward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1) }
        default: return nil
        }
    }
    
    /**
     The standard text document proxy input action, if any.
     
     An input action either inserts or deletes text from the
     text document proxy.
     */
    var standardTextDocumentProxyInputAction: GestureAction? {
        if self.isPrimaryAction { return { $0?.textDocumentProxy.insertText("\n") }}
        
        switch self {
        case .backspace: return { $0?.textDocumentProxy.deleteBackward() }
        case .character(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .emoji(let emoji): return { $0?.textDocumentProxy.insertText(emoji.char) }
        case .newLine: return { $0?.textDocumentProxy.insertText("\n") }
        case .return: return { $0?.textDocumentProxy.insertText("\n") }
        case .space: return { $0?.textDocumentProxy.insertText(" ") }
        case .tab: return { $0?.textDocumentProxy.insertText("\t") }
        default: return nil
        }
    }
}
