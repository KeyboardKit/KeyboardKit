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
 
 Actions without a standard behavior require custom handling
 and can for instance be handled by a custom action handler.
 */
public enum KeyboardAction: Codable, Equatable {
    
    /// A "no action" placeholder action.
    case none
    
    /// `.backspace` deletes text backwards in the text document proxy when `tapped` and repeats this action until the button is `released`.
    case backspace
    
    /// `.character` sends a text character to the text document proxy when `tapped`.
    case character(String)
    
    /// `.command` represents a command key.
    case command
    
    /// `.control` represents a control key.
    case control
    
    /// `.custom` is a custom, named action that you can handle in a custom action handler.
    case custom(named: String)
    
    /// `.dictation` represents a dictation key.
    case dictation
    
    /// `.dismissKeyboard` dismisses the keyboard when `tapped`.
    case dismissKeyboard
    
    /// `.emoji` sends an emoji to the text document proxy when `tapped`.
    case emoji(Emoji)
    
    /// `.emojiCategory` can be used to show a specific emoji category.
    case emojiCategory(EmojiCategory)
    
    /// `.escape` represents an `esc` key.
    case escape
    
    /// `.function` represents a `fn` key.
    case function
    
    /// `.image` can be used to show an embedded image asset.
    case image(description: String, keyboardImageName: String, imageName: String)
    
    /// `.keyboardType` changes the keyboard type when `tapped`.
    case keyboardType(KeyboardType)
    
    /// `.moveCursorBackward` moves the cursor back one position when `tapped`.
    case moveCursorBackward
    
    /// `.moveCursorForward` moves the cursor forward one position when `tapped`.
    case moveCursorForward
    
    /// `.newLine` sends a new line character to the text proxy when `tapped`.
    case newLine
    
    /// `.nextKeyboard` triggers the main keyboard switcher when `tapped` and `long pressed`.
    case nextKeyboard
    
    /// `.nextLocale` selects the next locale in the keyboard context when `tapped` and `long pressed`.
    case nextLocale
    
    /// `.option` represents a macOS `option` key.
    case option
    
    /// `.primary` is a primary button, e.g. `go`, `search` etc..
    case primary(PrimaryType)
    
    /// `.return` has the same behavior as a `newLine`, but is supposed to show a text instead of an arrow.
    case `return`
    
    /// `.settings` can be used to show a settings window or trigger a settings action.
    case settings
    
    /// `.shift` changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`.
    case shift(currentState: KeyboardCasing)
    
    /// `.space` sends a space to the text document proxy when `tapped`.
    case space
    
    /// `.systemImage` can be used to show a system image asset (SF Symbol).
    case systemImage(description: String, keyboardImageName: String, imageName: String)
    
    /// `.tab` sends a tab to the text document proxy when `tapped`.
    case tab
}


// MARK: - Public Extensions

public extension KeyboardAction {
    
    /**
     This type can be used together with the `.primary` type.
     
     A primary button is the color accented button that will
     have the same effect as return in a native iOS keyboard.
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
