//
//  KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-02.
//  Copyright © 2018-2025 Daniel Saidi. All rights reserved.
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
/// behavior when using a ``StandardActionHandler``. Actions
/// that don't have a standard behavior must be handled with
/// a custom ``KeyboardActionHandler``.
public enum KeyboardAction: KeyboardModel {

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
    
    /// Changes keyboard case when released and double tapped.
    ///
    /// > Note: We currently need the current case, since it
    /// is used for uniqueness. Without it, the keyboard key
    /// isn't properly updated when the context case changes.
    /// We should however try to find a way around it, since
    /// the action should just be `shift`.
    case shift(Keyboard.KeyboardCase)
    
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
    case url(_ url: URL?, id: String?)
}

public extension KeyboardAction {
    
    /// An ``KeyboardAction/diacritic(_:)`` alias.
    static func accent(
        _ accent: Keyboard.Accent
    ) -> KeyboardAction {
        .diacritic(accent)
    }

    /// An `emoji(_:)` shorthand.
    static func emoji(
        _ char: String
    ) -> KeyboardAction {
        .emoji(.init(char))
    }

    /// An ``KeyboardAction/url(_:id:)`` shorthand.
    static func url(
        _ url: URL?
    ) -> KeyboardAction {
        .url(url, id: nil)
    }

    /// An ``KeyboardAction/url(_:id:)`` shorthand.
    static func url(
        _ url: String?
    ) -> KeyboardAction {
        guard let url else { return .url(.init(string: ""), id: nil) }
        return .url(.init(string: url), id: nil)
    }
}


// MARK: - Public Extensions

public extension KeyboardAction {

    /// Whether or not the action is an alphabetic type.
    var isAlphabeticKeyboardTypeAction: Bool {
        switch self {
        case .keyboardType(let type): type == .alphabetic
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

    /// Whether or not the action is a keyboard type action.
    func isKeyboardTypeAction(_ keyboardType: Keyboard.KeyboardType) -> Bool {
        switch self {
        case .keyboardType(let type): type == keyboardType
        default: false
        }
    }
}
