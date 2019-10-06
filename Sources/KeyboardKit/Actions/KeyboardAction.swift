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
     The standard action, if any, that should be applied to
     the input view controller when the action is triggered.
     */
    var standardInputViewControllerAction: ((UIInputViewController?) -> Void)? {
        switch self {
        case .none: return nil
        case .backspace: return nil
        case .capsLock: return nil
        case .character: return nil
        case .command: return nil
        case .custom: return nil
        case .dismissKeyboard: return { controller in controller?.dismissKeyboard() }
        case .escape: return nil
        case .function: return nil
        case .image: return nil
        case .moveCursorBackward: return nil
        case .moveCursorForward: return nil
        case .newLine: return nil
        case .option: return nil
        case .shift: return nil
        case .shiftDown: return nil
        case .space: return nil
        case .switchKeyboard: return nil
        case .switchToKeyboard: return nil
        case .tab: return nil
        }
    }
    
    /**
     The standard action, if any, that should be applied to
     the texst document proxy when the action is triggered.
     */
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> Void)? {
        switch self {
        case .none: return nil
        case .backspace: return { proxy in proxy?.deleteBackward() }
        case .capsLock: return nil
        case .character(let char): return { proxy in proxy?.insertText(char) }
        case .command: return nil
        case .custom: return nil
        case .dismissKeyboard: return nil
        case .escape: return nil
        case .function: return nil
        case .image: return nil
        case .moveCursorBackward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .newLine: return { proxy in proxy?.insertText("\n") }
        case .option: return nil
        case .shift: return nil
        case .shiftDown: return nil
        case .space: return { proxy in proxy?.insertText(" ") }
        case .switchKeyboard: return nil
        case .switchToKeyboard: return nil
        case .tab: return { proxy in proxy?.insertText("\t") }
        }
    }
}
