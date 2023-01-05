//
//  KeyboardAction+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation

/**
 This extension defines standard gesture actions for various
 keyboard actions.
 
 You can trigger these actions directly, but a more flexible
 approach is to use a ``KeyboardActionHandler``. The library
 also uses these actions by default.
 */
public extension KeyboardAction {
    
    /**
     This typealias represents a gesture action that affects
     the provided view controller.

     > NOTE: This will NOT use a view controller in 7.0, but
     rather use a protocol, to be available to all platforms.
     */
    typealias GestureAction = (KeyboardInputViewController?) -> Void
    
    /**
     The action that by default should be triggered when the
     action is triggered with a certain ``KeyboardGesture``.
     */
    func standardAction(for gesture: KeyboardGesture) -> GestureAction? {
        switch gesture {
        case .doubleTap: return standardDoubleTapAction
        case .longPress: return standardLongPressAction
        case .press: return standardPressAction
        case .release: return nil   // TODO: Return the standardReleaseAction in 7.9
        case .repeatPress: return standardRepeatAction
        case .tap: return standardReleaseAction
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
        case .backspace: return standardReleaseAction
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
        case .keyboardType(let type): return { $0?.keyboardContext.keyboardType = type }
        default: return nil
        }
    }
    
    /**
     The action that by default should be triggered when the
     action is released.
     */
    var standardReleaseAction: GestureAction? {
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
     The action that by default should be triggered when the
     action is pressed, and repeated until it is released.
     */
    var standardRepeatAction: GestureAction? {
        switch self {
        case .backspace: return standardReleaseAction
        default: return nil
        }
    }
    
    /**
     The standard text document proxy action, if any.
     */
    var standardTextDocumentProxyAction: GestureAction? {
        switch self {
        case .backspace: return { $0?.textDocumentProxy.deleteBackward(range: $0?.keyboardBehavior.backspaceRange ?? .char) }
        case .character(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .characterMargin(let char): return { $0?.textDocumentProxy.insertText(char) }
        case .emoji(let emoji): return { $0?.textDocumentProxy.insertText(emoji.char) }
        case .moveCursorBackward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { $0?.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1) }
        case .newLine: return { $0?.textDocumentProxy.insertText(.newline) }
        case .primary: return { $0?.textDocumentProxy.insertText(.newline) }
        case .return: return { $0?.textDocumentProxy.insertText(.newline) }
        case .space: return { $0?.textDocumentProxy.insertText(.space) }
        case .tab: return { $0?.textDocumentProxy.insertText(.tab) }
        default: return nil
        }
    }
}
#endif
