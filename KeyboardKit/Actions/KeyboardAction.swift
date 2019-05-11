//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This enum contains all currently supported keyboard actions.
 
 */

import UIKit

public enum KeyboardAction: Equatable {
    
    case
    none,
    backspace,
    character(String),
    dismissKeyboard,
    image(description: String, keyboardImageName: String, imageName: String),
    moveCursorBack,
    moveCursorForward,
    newLine,
    shift,
    space,
    switchKeyboard,
    switchToNumericKeyboard
}

public extension KeyboardAction {
    
    var standardInputViewControllerAction: ((UIInputViewController?) -> ())? {
        switch self {
        case .none: return nil
        case .backspace: return nil
        case .dismissKeyboard: return { controller in controller?.dismissKeyboard() }
        case .character: return nil
        case .image: return nil
        case .moveCursorBack: return nil
        case .moveCursorForward: return nil
        case .newLine: return nil
        case .shift: return nil
        case .space: return nil
        case .switchKeyboard: return nil
        case .switchToNumericKeyboard: return nil
        }
    }
    
    var standardTextDocumentProxyAction: ((UITextDocumentProxy?) -> ())? {
        switch self {
        case .none: return nil
        case .backspace: return { proxy in proxy?.deleteBackward() }
        case .dismissKeyboard: return nil
        case .character(let char): return { proxy in proxy?.insertText(char) }
        case .image: return nil
        case .moveCursorBack: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .moveCursorForward: return { proxy in proxy?.adjustTextPosition(byCharacterOffset: -1) }
        case .newLine: return { proxy in proxy?.insertText("\n") }
        case .shift: return nil
        case .space: return { proxy in proxy?.insertText(" ") }
        case .switchKeyboard: return nil
        case .switchToNumericKeyboard: return nil
        }
    }
}
