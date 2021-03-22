//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum specifies available keyboard actions. They can be
 bound to keyboard buttons or triggered by an action handler.
 
 Many actions have standard gesture behaviors. However, many
 don't and are just here to let you create your keyboards in
 a declarative way. Such actions require custom handling and
 can for instance be handled by a custom action handler.
 */
public enum KeyboardAction: Equatable {
    
    case
        none,
        backspace,
        character(String),
        command,
        control,
        custom(name: String),
        dictation,
        dismissKeyboard,
        emoji(Emoji),
        emojiCategory(_ category: EmojiCategory),
        escape,
        function,
        image(description: String, keyboardImageName: String, imageName: String),
        keyboardType(KeyboardType),
        moveCursorBackward,
        moveCursorForward,
        newLine,
        nextKeyboard,
        nextLocale,
        option,
        primary(_ type: PrimaryType),
        `return`,
        settings,
        shift(currentState: KeyboardCasing),
        space,
        systemImage(description: String, keyboardImageName: String, imageName: String),
        tab
    
    @available(*, deprecated, renamed: "primary")
    case done, go, ok, search
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    /**
     This type can be used together with the `.primary` type.
     A primary button is the color accented button that will
     have the same effect as a return key.
     */
    enum PrimaryType: Equatable {
        case done, go, ok, search
    }
    
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
     Whether or not the action is a primary action, which is
     that it is intended to perform a committing action.
     */
    var isPrimaryAction: Bool {
        switch self {
        case .done, .go, .ok, .primary, .search: return true
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
     Whether or not the action is a shift action.
     */
    var isSpace: Bool {
        switch self {
        case .character(let char): return char == " "
        case .space: return true
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
        case .nextLocale: return true
        case .option: return true
        case .return: return true
        case .shift: return true
        case .settings: return true
        case .tab: return true
        default: return false
        }
    }
}
