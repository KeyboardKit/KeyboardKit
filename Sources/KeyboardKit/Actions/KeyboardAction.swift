//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines keyboard-specific actions that correspond
 to actions that can be found on various keyboards.
 
 Keyboard actions can be bound to buttons and triggered with
 a ``KeyboardActionHandler``. Keyboard actions are also used
 to define keyboard layouts and provide a declarative way to
 express a keyboard layout without having to specify exactly
 how your actions will be executed.

 The documentation for each action type describes the type's
 standard behavior, if any. Types that don't have a standard
 behavior require a custom ``KeyboardActionHandler``.
 */
public enum KeyboardAction: Codable, Equatable {

    /// Deletes backwards when pressed, and repeats until released.
    case backspace
    
    /// Inserts a text character when released.
    case character(String)
    
    /// Inserts a text character when released, but is rendered as empty space.
    case characterMargin(String)
    
    /// Represents a command (⌘) key.
    case command
    
    /// Represents a control (⌃) key.
    case control

    /// A custom action that you can handle in any way you want.
    case custom(named: String)
    
    /// Represents a dictation key.
    case dictation
    
    /// Dismisses the keyboard when released.
    case dismissKeyboard
    
    /// Inserts an emoji when released.
    case emoji(Emoji)
    
    /// Can be used to show a specific emoji category.
    case emojiCategory(EmojiCategory)
    
    /// Represents an escape (esc) key.
    case escape
    
    /// Represents a function (fn) key.
    case function
    
    /// Can be used to refer to an image asset.
    case image(description: String, keyboardImageName: String, imageName: String)
    
    /// Changes the keyboard type when pressed.
    case keyboardType(KeyboardType)
    
    /// Moves the input cursor back one step when released.
    case moveCursorBackward
    
    /// Moves the input cursor forward one step when released.
    case moveCursorForward
    
    /// Represents a keyboard switcher (🌐) button and triggers the keyboard switch action when long pressed and released.
    case nextKeyboard
    
    /// Triggers the locale switcher action when long pressed and released.
    case nextLocale
    
    /// A placeholder action that does nothing and should not be rendered.
    case none
    
    /// Represents an option (⌥) key.
    case option
    
    /// Represents a primary return button, e.g. `return`, `go`, `search` etc.
    case primary(ReturnType)
    
    /// A custom action that can be used to e.g. show a settings screen.
    case settings
    
    /// Changes the keyboard type to `.alphabetic(.uppercased)` when released and `.capslocked` when double tapped.
    case shift(currentCasing: KeyboardCase)
    
    /// Inserts a space when released and moves the cursor when long pressed.
    case space
    
    /// Can be used to refer to a system image (SF Symbol).
    case systemImage(description: String, keyboardImageName: String, imageName: String)
    
    /// Inserts a tab when released.
    case tab
}


// MARK: - Public Extensions

public extension KeyboardAction {

    /**
     Whether or not the action is an alphabetic type.
     */
    var isAlphabeticKeyboardTypeAction: Bool {
        switch self {
        case .keyboardType(let type): return type.isAlphabetic
        default: return false
        }
    }
    
    /**
     Whether or not the action is a character action.
     */
    var isCharacterAction: Bool {
        switch self {
        case .character: return true
        default: return false
        }
    }

    /**
     Whether or not the action is an emoji action.
     */
    var isEmojiAction: Bool {
        switch self {
        case .emoji: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is an input action.

     An input action inserts content into the text proxy and
     is by default rendered as a light button.
     */
    var isInputAction: Bool {
        switch self {
        case .character: return true
        case .characterMargin: return true
        case .emoji: return true
        case .image: return true
        case .space: return true
        case .systemImage: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a primary action.

     Primary actions always insert a new line into the proxy,
     but can be rendered in various ways. For instance, most
     primary actions will by default use a blue color, while
     `.return` and `.newLine` are rendered as system buttons.
     */
    var isPrimaryAction: Bool {
        switch self {
        case .primary: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a shift action.
     */
    var isShiftAction: Bool {
        switch self {
        case .shift: return true
        default: return false
        }
    }

    /**
     Whether or not the action primary serves as a spacer.
     */
    var isSpacer: Bool {
        switch self {
        case .characterMargin: return true
        case .none: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a system action, which the
     library by default renders as darker buttons.
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
        case .nextKeyboard: return true
        case .nextLocale: return true
        case .option: return true
        case .primary(let type): return type.isSystemAction
        case .shift: return true
        case .settings: return true
        case .tab: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is an uppercase shift action.
     */
    var isUppercasedShiftAction: Bool {
        switch self {
        case .shift(let state): return state.isUppercased
        default: return false
        }
    }

    /**
     Whether or not the action is a keyboard type action.
     */
    func isKeyboardTypeAction(_ keyboardType: KeyboardType) -> Bool {
        switch self {
        case .keyboardType(let type): return type == keyboardType
        default: return false
        }
    }
}
