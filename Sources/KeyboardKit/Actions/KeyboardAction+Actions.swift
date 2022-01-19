//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import Foundation

/**
 This extension defines various actions that by default will
 apply to various keyboard actions.
 
 You can trigger these actions directly, but a more flexible
 way is to use an action handler. You can also choose to not
 trigger these actions at all and handle keyboard actions in
 completely custom ways.
 */
public extension KeyboardAction {
    
    typealias GestureAction = (KeyboardInputViewController?) -> Void
    
    
    /**
     The action that by default should be triggered when the
     provided `gesture` is performed on the keyboard action.
     */
    func standardAction(for gesture: KeyboardGesture) -> GestureAction? {
        switch gesture {
        case .doubleTap: return standardDoubleTapAction
        case .longPress: return standardLongPressAction
        case .press: return standardPressAction
        case .release: return standardReleaseAction
        case .repeatPress: return standardRepeatAction
        case .tap: return standardTapAction
        }
    }
    
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
     keyboard action is pressed.
     */
    var standardPressAction: GestureAction? {
        switch self {
        case .keyboardType(let type): return { $0?.keyboardContext.keyboardType = type }
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
     keyboard action is pressed, repeated until released.
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
        if let action = standardTextDocumentProxyAction { return action }
        switch self {
        case .dismissKeyboard: return { $0?.dismissKeyboard() }
        case .nextLocale: return { $0?.keyboardContext.selectNextLocale() }
        case .shift(let currentState): return {
            switch currentState {
            case .lowercased: $0?.keyboardContext.keyboardType = .alphabetic(.uppercased)
            case .auto, .capsLocked, .uppercased: $0?.keyboardContext.keyboardType = .alphabetic(.lowercased)
            }
        }
        default: return nil
        }
    }
    
    /**
     The standard text document proxy action, if any.
     
     Text document proxy actions affect the proxy itself and
     not its content.
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
     
     Text document proxy input actions affect the text proxy
     content, e.g. inserting or deleting text.
     */
    var standardTextDocumentProxyInputAction: GestureAction? {
        if self.isPrimaryAction { return { $0?.textDocumentProxy.insertText(.newline) }}
        switch self {
        case .backspace: return { $0?.textDocumentProxy.deleteBackward(range: $0?.keyboardBehavior.backspaceRange ?? .char) }
        case .character(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .characterMargin(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .emoji(let emoji): return { $0?.textDocumentProxy.insertText(emoji.char) }
        case .newLine: return { $0?.textDocumentProxy.insertText(.newline) }
        case .return: return { $0?.textDocumentProxy.insertText(.newline) }
        case .space: return { $0?.textDocumentProxy.insertText(.space) }
        case .tab: return { $0?.textDocumentProxy.insertText(.tab) }
        default: return nil
        }
    }
}
#endif
