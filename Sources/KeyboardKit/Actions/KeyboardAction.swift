//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This enum defines keyboard-specific actions, and is also
/// a namespace for keyboard action-related types.
///
/// Some actions are ``KeyboardAction/character(_:)``, which
/// inserts text, ``KeyboardAction/keyboardType(_:)``, which
/// switches keyboard type, etc.
///
/// The idea with these keyboard actions is that they can be
/// used to triggered keyboard-related operations, e.g. when
/// tapping a button, or when certain events happen. You can
/// trigger actions with a ``KeyboardActionHandler``.
///
/// The documentation for each action describes the standard
/// behavior when using a ``KeyboardAction/StandardHandler``,
/// with a ``Keyboard/StandardBehavior``.
///
/// Types that don't define any standard behaviors require a
/// custom ``KeyboardActionHandler`` to be handled.
public enum KeyboardAction: Codable, Equatable {

    /// Deletes backwards when pressed, and repeats until released.
    case backspace
    
    /// Switch to a caps-lock keyboard when pressed.
    case capsLock
    
    /// Inserts a text character when released.
    case character(String)
    
    /// Inserts a text character when released, rendered as empty space.
    case characterMargin(String)
    
    /// Represents a command (⌘) key.
    case command
    
    /// Represents a control (⌃) key.
    case control

    /// A custom action that you can handle in any custom way.
    case custom(named: String)
    
    /// A diacritic action, that will replace any previous match when release.
    case diacritic(_ diacritic: Keyboard.Diacritic)
    
    /// Represents a dictation key.
    case dictation
    
    /// Dismisses the keyboard when released.
    case dismissKeyboard
    
    /// Inserts an emoji when released.
    case emoji(Emoji)
    
    /// Represents an escape (esc) key.
    case escape
    
    /// Represents a function (fn) key.
    case function
    
    /// Can be used to refer to an image asset.
    case image(description: String, keyboardImageName: String, imageName: String)
    
    /// Changes the keyboard type when pressed.
    case keyboardType(Keyboard.KeyboardType)
    
    /// Moves the input cursor back one step when released.
    case moveCursorBackward
    
    /// Moves the input cursor forward one step when released.
    case moveCursorForward
    
    /// Triggers the system keyboard switcher on release and long press.
    case nextKeyboard
    
    /// Triggers a locale switcher action on release and menu on long press.
    case nextLocale
    
    /// A placeholder action that does nothing and should be rendered as empty space.
    case none
    
    /// Represents an option (⌥) key.
    case option
    
    /// A primary key, e.g. `return`, `search` etc. that inserts a new line on release.
    case primary(Keyboard.ReturnKeyType)
    
    /// Represents a settings (⚙️) key.
    case settings
    
    /// Changes keyboard to `.alphabetic(.uppercased)` when released and `.capslocked` when double tapped.
    case shift(currentCasing: Keyboard.Case)
    
    /// Inserts a space when released and can perform custom actions when long pressed.
    case space
    
    /// Can be used to refer to a system image (SF Symbol).
    case systemImage(description: String, keyboardImageName: String, imageName: String)

    /// Open system settings for the app when released.
    case systemSettings
    
    /// Inserts a tab when released.
    case tab
    
    /// Inserts a text string when released.
    case text(String)

    /// Open an url when released, using a custom id for identification.
    case url(_ url: URL?, id: String? = nil)
}

public extension KeyboardAction {
    
    /// An `.emoji(_:)` shorthand that inserts an emoji when
    /// released.
    ///
    /// > Note: This typealias is meant to make it easier to
    /// find the ``KeyboardAction/diacritic(_:)`` action.
    static func accent(
        _ accent: Keyboard.Accent
    ) -> KeyboardAction {
        .diacritic(accent)
    }
    
    /// An `.emoji(_:)` shorthand that inserts an emoji when
    /// released.
    static func emoji(
        _ char: String
    ) -> KeyboardAction {
        .emoji(.init(char))
    }
}


// MARK: - Public Extensions

public extension KeyboardAction {

    /// Whether or not the action is an alphabetic type.
    var isAlphabeticKeyboardTypeAction: Bool {
        switch self {
        case .keyboardType(let type): type.isAlphabetic
        default: false
        }
    }
    
    /// Whether or not the action is a character action.
    var isCharacterAction: Bool {
        switch self {
        case .character: true
        default: false
        }
    }

    /// Whether or not the action is an emoji action.
    var isEmojiAction: Bool {
        switch self {
        case .emoji: true
        default: false
        }
    }
    
    /// Whether or not the action is an input action.
    ///
    /// Input actions insert content into the text proxy and
    /// are by default rendered as light buttons.
    var isInputAction: Bool {
        switch self {
        case .character: true
        case .characterMargin: true
        case .diacritic: true
        case .emoji: true
        case .image: true
        case .space: true
        case .systemImage: true
        case .text: true
        default: false
        }
    }
    
    /// Whether or not the action is a primary action.
    ///
    /// Primary actions insert new lines into the proxy, but
    /// can be rendered differently to express intent.
    var isPrimaryAction: Bool {
        switch self {
        case .primary: true
        default: false
        }
    }
    
    /// Whether or not the action is a shift action.
    var isShiftAction: Bool {
        switch self {
        case .shift: true
        default: false
        }
    }

    /// Whether or not the action primary serves as a spacer.
    var isSpacer: Bool {
        switch self {
        case .characterMargin: true
        case .none: true
        default: false
        }
    }
    
    /// Whether or not the action is a dark system action.
    var isSystemAction: Bool {
        switch self {
        case .backspace: true
        case .capsLock: true
        case .command: true
        case .control: true
        case .dictation: true
        case .dismissKeyboard: true
        case .escape: true
        case .function: true
        case .keyboardType: true
        case .moveCursorBackward: true
        case .moveCursorForward: true
        case .nextKeyboard: true
        case .nextLocale: true
        case .option: true
        case .primary(let type): type.isSystemAction
        case .shift: true
        case .settings: true
        case .tab: true
        case .url: true
        default: false
        }
    }
    
    /// Whether or not the action is uppercase shift.
    var isUppercasedShiftAction: Bool {
        switch self {
        case .shift(let state): state.isUppercased
        default: false
        }
    }

    /// Whether or not the action is a keyboard type action.
    func isKeyboardTypeAction(_ keyboardType: Keyboard.KeyboardType) -> Bool {
        switch self {
        case .keyboardType(let type): type == keyboardType
        default: false
        }
    }
}


// MARK: - Accessibility

public extension KeyboardAction {
    
    /// The standard accessibility label for the action.
    var standardAccessibilityLabel: String? {
        switch self {
        case .backspace: "Backspace"
        case .capsLock: "Capslock"
        case .character(let char): char
        case .characterMargin: nil
        case .command: "Command"
        case .control: "Control"
        case .custom(let name): name
        case .diacritic(let val): val.char
        case .dictation: "Dictation"
        case .dismissKeyboard: "Dismiss Keyboard"
        case .emoji(let emoji): "Emoji - \(emoji)"
        case .escape: "Escape"
        case .function: "Function"
        case .image(let desc, _, _): desc
        case .keyboardType(let keyboardType): "Keyboard Type - \(keyboardType.id)"
        case .moveCursorBackward: "Move Cursor Backward"
        case .moveCursorForward: "Move Cursor Forward"
        case .nextKeyboard: "Next Keyboard"
        case .nextLocale: "Next Locale"
        case .none: nil
        case .option: "Option"
        case .primary(let returnKeyType): returnKeyType.id
        case .settings: "Settings"
        case .shift: "Shift"
        case .space: KKL10n.space.text
        case .systemImage(let desc, _, _): desc
        case .systemSettings: "System Settings"
        case .tab: "Tab"
        case .text(let text): text
        case .url(let url, _): "Open \(url?.absoluteString ?? "invalid url")"
        }
    }
}
