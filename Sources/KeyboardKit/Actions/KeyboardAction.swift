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
    emojiCategory(_ category: EmojiCategory, startPage: Int, endPage: Int),
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
    
    @available(*, deprecated, renamed: "keyboardType")
    case switchToKeyboard(KeyboardType)
}


// MARK: - Public Properties

public extension KeyboardAction {
    
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
        case .character: return false
        case .command: return true
        case .custom: return false
        case .dismissKeyboard: return true
        case .escape: return true
        case .function: return true
        case .image: return false
        case .keyboardType: return true
        case .moveCursorBackward: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .nextKeyboard: return true
        case .option: return true
        case .shift: return true
        case .shiftDown: return true
        case .space: return false
        case .emojiCategory: return false
        case .switchToKeyboard: return true
        case .tab: return true
        case .none: return false
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     the input view controller when the action is triggered.
     */
    var standardInputViewControllerAction: ((UIInputViewController?) -> Void)? {
        switch self {
        case .dismissKeyboard: return { controller in controller?.dismissKeyboard() }
        default: return nil
        }
    }
    
    /**
     The standard action, if any, that should be executed on
     the text document proxy when the action is triggered.
     */
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> Void)? {
        switch self {
        case .backspace: return { proxy in proxy?.deleteBackward() }
        case .character(let char): return { proxy in proxy?.insertText(char) }
        case .moveCursorBackward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: 1) }
        case .newLine: return { proxy in proxy?.insertText("\n") }
        case .space: return { proxy in proxy?.insertText(" ") }
        case .tab: return { proxy in proxy?.insertText("\t") }
        default: return nil
        }
    }
}
