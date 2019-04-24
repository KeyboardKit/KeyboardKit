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
    image(description: String, keyboardImageName: String, imageName: String),
    moveCursorBack,
    moveCursorForward,
    newLine,
    nextKeyboard,
    shift,
    space
}

public extension KeyboardAction {
    
    var shouldRepeatOnLongPress: Bool {
        switch self {
        case .none: return false
        case .backspace: return true
        case .character: return true
        case .image: return false
        case .moveCursorBack: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .nextKeyboard: return false
        case .shift: return false
        case .space: return true
        }
    }
}
