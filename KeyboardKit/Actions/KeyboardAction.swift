//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This enum contains all currently supported keyboard actions.
 Most actions have standard tap actions that either apply to
 the input view controller or its document text proxy, while
 many still require manual handling.
 
 For instance, `image` can't be handled by KeyboardKit since
 it requires app-specific assets, and the keyboard switchers
 can't be handled either, since there's no universal concept
 of an "alphabetic" keyboard. These king of actions are just
 ways for you to express your intent.
 
 */

import UIKit

public typealias KeyboardActionRow = [KeyboardAction]

public typealias KeyboardActionRows = [KeyboardActionRow]

public enum KeyboardAction: Equatable {
    
    case
    none,
    backspace,
    capsLock,
    character(String),
    dismissKeyboard,
    image(description: String, keyboardImageName: String, imageName: String),
    moveCursorBackward,
    moveCursorForward,
    newLine,
    shift,
    shiftDown,
    space,
    switchKeyboard,
    switchToAlphabeticKeyboard,
    switchToEmojiKeyboard,
    switchToNumericKeyboard,
    switchToSymbolicKeyboard
}


// MARK: - Public Properties

public extension KeyboardAction {
    
    var standardInputViewControllerAction: ((UIInputViewController?) -> ())? {
        switch self {
        case .none: return nil
        case .backspace: return nil
        case .capsLock: return nil
        case .character: return nil
        case .dismissKeyboard: return { controller in controller?.dismissKeyboard() }
        case .image: return nil
        case .moveCursorBackward: return nil
        case .moveCursorForward: return nil
        case .newLine: return nil
        case .shift: return nil
        case .shiftDown: return nil
        case .space: return nil
        case .switchKeyboard: return nil
        case .switchToAlphabeticKeyboard: return nil
        case .switchToEmojiKeyboard: return nil
        case .switchToNumericKeyboard: return nil
        case .switchToSymbolicKeyboard: return nil
        }
    }
    
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> ())? {
        switch self {
        case .none: return nil
        case .backspace: return { proxy in proxy?.deleteBackward() }
        case .capsLock: return nil
        case .character(let char): return { proxy in proxy?.insertText(char) }
        case .dismissKeyboard: return nil
        case .image: return nil
        case .moveCursorBackward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .newLine: return { proxy in proxy?.insertText("\n") }
        case .shift: return nil
        case .shiftDown: return nil
        case .space: return { proxy in proxy?.insertText(" ") }
        case .switchKeyboard: return nil
        case .switchToAlphabeticKeyboard: return nil
        case .switchToEmojiKeyboard: return nil
        case .switchToNumericKeyboard: return nil
        case .switchToSymbolicKeyboard: return nil
        }
    }
}
