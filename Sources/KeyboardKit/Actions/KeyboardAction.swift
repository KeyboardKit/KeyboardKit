//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum specifies available keyboard actions that you can
 bind to keyboard buttons or trigger with an action handler.
 
 Many actions have standard gesture behaviors. However, many
 don't and are just here to let you create your keyboards in
 a declarative way.
 
 Actions without a standard behavior require custom handling,
 e.g. by using a custom ``KeyboardActionHandler``.
 
 The documentation for the different enum cases describe the
 standard behavior of each action, if any.
 */
public enum KeyboardAction: Codable, Equatable {
    
    /// A "no action" placeholder action.
    case none
    
    /// Deletes text backwards in the text document proxy when tapped and repeats this action until the button is released.
    case backspace
    
    /// Sends a text character to the text document proxy when tapped.
    case character(String)
    
    /// Represents a command (⌘) key.
    case command
    
    /// Represents a control (⌃) key.
    case control
    
    /// A custom, named action that you can handle in a custom action handler.
    case custom(named: String)
    
    /// Represents a dictation key.
    case dictation
    
    /// Dismisses the keyboard when tapped.
    case dismissKeyboard
    
    /// Sends an emoji to the text document proxy when tapped.
    case emoji(Emoji)
    
    /// Can be used to show a specific emoji category.
    case emojiCategory(EmojiCategory)
    
    /// Represents an escape (esc) key.
    case escape
    
    /// Represents a function (fn) key.
    case function
    
    /// Can be used to refer to an embedded image asset.
    case image(description: String, keyboardImageName: String, imageName: String)
    
    /// Changes the keyboard type when tapped.
    case keyboardType(KeyboardType)
    
    /// Moves the cursor back one position when tapped.
    case moveCursorBackward
    
    /// Moves the cursor forward one position when tapped.
    case moveCursorForward
    
    /// Sends a new line to the text proxy when tapped.
    case newLine
    
    /// Represents a next keyboard (🌐) button that triggers the keyboard switcher when tapped and pressed.
    case nextKeyboard
    
    /// Selects the next locale in the keyboard context when tapped and pressed.
    case nextLocale
    
    /// Represents an option (⌥) key.
    case option
    
    /// A primary button, e.g. `go`, `search` etc.
    case primary(PrimaryType)
    
    /// Has the same behavior as `newLine`, but is supposed to show a text instead of an arrow.
    case `return`
    
    /// A custom action that can be used to show a settings screen or anything you like.
    case settings
    
    /// Changes the keyboard type to `.alphabetic(.uppercased)` when tapped and `.capslocked` when double tapped.
    case shift(currentState: KeyboardCasing)
    
    /// Sends a space to the text document proxy when tapped.
    case space
    
    /// Can be used to refer to a system image (SF Symbol).
    case systemImage(description: String, keyboardImageName: String, imageName: String)
    
    /// Sends a tab to the text document proxy when tapped.
    case tab
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    /**
     This type can be used together with a `.primary` action.
     
     Primary buttons are color accented buttons that trigger
     a submit action in the keyboard. This submit is done by
     sending a new line to the proxy, just as `.return` does.
     */
    enum PrimaryType: String, CaseIterable, Codable, Equatable, Identifiable {
        
        case done, go, newLine, ok, search
        
        /**
         The type's unique identifier.
         */
        public var id: String { rawValue }
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
     Whether or not the action is an input action.
     
     An input action button is rendered as a light button in
     native iOS keyboards.
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
     Whether or not the action is a keyboard type action.
     */
    var isKeyboardType: Bool {
        switch self {
        case .keyboardType: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a primary action.
     
     A primary button is the color accented button that will
     have the same effect as return in a native iOS keyboard.
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
    var isShift: Bool {
        switch self {
        case .shift: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a space action.
     */
    var isSpace: Bool {
        switch self {
        case .character(let char): return char == " "
        case .space: return true
        default: return false
        }
    }
    
    /**
     Whether or not the action is a system action.
     
     An system action button is rendered as a dark button in
     native iOS keyboards.
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
