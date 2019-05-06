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
    switchKeyboard
}

public extension KeyboardAction {
    
    var isInputViewControllerAction: Bool {
        switch self {
        case .none: return false
        case .backspace: return false
        case .character: return false
        case .dismissKeyboard: return true
        case .image: return false
        case .moveCursorBack: return false
        case .moveCursorForward: return false
        case .newLine: return false
        case .shift: return false
        case .space: return false
        case .switchKeyboard:return true
        }
    }
    
    var isTextDocumentProyAction: Bool {
        switch self {
        case .none: return false
        case .backspace: return true
        case .character: return true
        case .dismissKeyboard: return false
        case .image: return false
        case .moveCursorBack: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .shift: return true
        case .space: return true
        case .switchKeyboard:return false
        }
    }
}
