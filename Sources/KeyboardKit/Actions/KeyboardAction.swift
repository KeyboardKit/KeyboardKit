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
 
 Most keyboard actions have a standard tap action that apply
 to the input view controller or its text document proxy.
 
 Many actions require manual handling, however. For instance,
 `image` can't be handled here since it requires assets. The
 keyboard switchers can't be handled here either since there
 is no universally applicable "alphabetic keyboard". Actions
 like these are ways for you to express your intent, but you
 must handle them yourself.
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
    escape,
    function,
    image(description: String, keyboardImageName: String, imageName: String),
    moveCursorBackward,
    moveCursorForward,
    newLine,
    option,
    shift,
    shiftDown,
    space,
    switchKeyboard,
    switchToKeyboard(KeyboardType),
    tab
}


// MARK: - Public Properties

public extension KeyboardAction {
    
    /**
     Whether or not the action is a content input action.
     */
    var isInputAction: Bool {
        switch self {
        case .character: return true
        case .image: return true
        default: return false
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
     Whether or not the action is something that handles the
     system instead of content.
     */
    var isSystemAction: Bool {
        switch self {
        case .backspace: return true
        case .capsLock: return true
        case .command: return true
        case .dismissKeyboard: return true
        case .escape: return true
        case .function: return true
        case .moveCursorBackward: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .option: return true
        case .shift: return true
        case .shiftDown: return true
        case .space: return true
        case .switchKeyboard: return true
        case .switchToKeyboard: return true
        case .tab: return true
        default: return false
        }
    }
    
    /**
     The standard action, if any, that should be applied to
     the input view controller when the action is triggered.
     */
    var standardInputViewControllerAction: ((UIInputViewController?) -> Void)? {
        switch self {
        case .dismissKeyboard: return { controller in controller?.dismissKeyboard() }
        default: return nil
        }
    }
    
    /**
     The standard action, if any, that should be applied to
     the texst document proxy when the action is triggered.
     */
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> Void)? {
        switch self {
        case .backspace: return { proxy in proxy?.deleteBackward() }
        case .character(let char): return { proxy in proxy?.insertText(char) }
        case .moveCursorBackward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .newLine: return { proxy in proxy?.insertText("\n") }
        case .space: return { proxy in proxy?.insertText(" ") }
        case .tab: return { proxy in proxy?.insertText("\t") }
        default: return nil
        }
    }
}
