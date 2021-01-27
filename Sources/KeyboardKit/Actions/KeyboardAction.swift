//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This action enum specifies all currently supported keyboard
 actions. They can be bound to keyboard buttons or triggered
 programatically by handing them to a `KeyboardActionHandler`.
 
 Many actions have a standard behavior for a certain gesture.
 If a behavior is always true, it is defined here, otherwise
 it's defined elsewhere. Many actions don't have a universal
 behavior, and solely exist to let you create your keyboards
 declaratively. These actions require custom handling.
*/
public enum KeyboardAction: Equatable {
    
    case
    none,
    backspace,
    character(String),
    control,
    command,
    custom(name: String),
    done,
    dictation,
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
    search,
    shift(currentState: KeyboardShiftState),
    systemImage(description: String, keyboardImageName: String, imageName: String),
    space,
    tab
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    /**
     Whether or not the action is an input action, which the
     native keyboards render as light buttons.
     */
    var isInputAction: Bool {
        switch self {
        case .character: return true
        case .emoji: return true
        case .image: return true
        case .space: return true
        case .systemImage: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a shift action.
     */
    var isShift: Bool {
        switch self {
        case .shift: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a system action, which the
     native keyboards render as dark buttons.
     */
    var isSystemAction: Bool {
        switch self {
        case .backspace: return true
        case .command: return true
        case .control: return true
        case .dictation: return true
        case .dismissKeyboard: return true
        case .emojiCategory: return true
        case .escape: return true
        case .function: return true
        case .keyboardType: return true
        case .moveCursorBackward: return true
        case .moveCursorForward: return true
        case .newLine: return true
        case .nextKeyboard: return true
        case .option: return true
        case .shift: return true
        case .tab: return true
        default: return false
        }
    }
}
