//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action enum specifies all currently supported keyboard
 actions and their standard behavior.
 
 Most actions have a standard behavior for a certain gesture
 when their used in system keyboards. This standard behavior
 is provided through `standardInputViewControllerAction` and
 `standardTextDocumentProxyAction`. Keyboard action handlers
 can choose to use these standard actions or ignore them.
 
 Many actions require manual handling since they do not have
 universal, app-agnostic behaviors. For instance, the `image`
 action depends on what you want to do with the tapped image.
 Actions like these are a way for you to express your intent,
 but require manual handling in a custom action handler.
*/
public enum KeyboardAction: Equatable {
    
    case
    none,
    backspace,
    capsLock,
    character(String),
    command,
    custom(name: String),
    dismissKeyboard,
    emoji(String),
    emojiCategory(_ category: EmojiCategory),
    escape,
    function,
    image(description: String, keyboardImageName: String, imageName: String),
    keyboardType(KeyboardType),
    moveCursorBackward,
    moveCursorForward,
    newLine,
    nextKeyboard,
    option,
    shift,
    shiftDown,
    space,
    tab
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    
    // MARK: - Types
    
    typealias GestureAction = (KeyboardInputViewController?) -> Void
    typealias InputViewControllerAction = (KeyboardInputViewController?) -> Void
    typealias TextDocumentProxyAction = (UITextDocumentProxy?) -> Void
    
    
    // MARK: - Properties
    
    /**
     This action can used to end a sentence, e.g. when space
     is double-tapped.
     */
    var endSentenceAction: GestureAction {
        return {
            $0?.textDocumentProxy.deleteBackward(times: 1)
            KeyboardAction.character(".").standardTapAction?($0)
        }
    }
    
    /**
     Whether or not the action is a delete action.
     */
    var isDeleteAction: Bool {
        switch self {
        case .backspace: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a content input action.
     */
    var isInputAction: Bool {
        switch self {
        case .character: return true
        case .emoji: return true
        case .image: return true
        case .space: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is something that handles the
     system instead of any kind of content.
     */
    var isSystemAction: Bool {
        switch self {
        case .backspace: return true
        case .capsLock: return true
        case .command: return true
        case .dismissKeyboard: return true
        case .escape: return true
        case .function: return true
        case .keyboardType: return true
        case .moveCursorBackward: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .nextKeyboard: return true
        case .option: return true
        case .shift: return true
        case .shiftDown: return true
        case .tab: return true
        default: return false
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     an input view controller, when this action is triggered
     with a double-tap.
     */
    var standardDoubleTapAction: GestureAction? {
        switch self {
        case .space: return endSentenceAction
        case .shift: return { $0?.changeKeyboardType(to: .alphabetic(.capsLocked)) }
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
        case .shift: return { $0?.changeKeyboardType(to: .alphabetic(.uppercased)) }
        case .shiftDown: return { $0?.changeKeyboardType(to: .alphabetic(.lowercased)) }
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
