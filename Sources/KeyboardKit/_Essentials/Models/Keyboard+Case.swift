//
//  Keyboard+Case.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines various keyboard shift states.
    enum KeyboardCase: String, Codable, Identifiable {

        case auto
        case capsLocked
        case lowercased
        case uppercased
    }
}

public extension Keyboard.KeyboardCase {

    /// The case's unique identifier.
    var id: String { rawValue }
    
    /// Whether or not the case is caps locked.
    var isCapsLocked: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: false
        }
    }
    
    /// Whether or not the case is lowercased.
    var isLowercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: false
        case .lowercased: true
        case .uppercased: false
        }
    }
    
    /// Whether or not the case is uppercased or capslocked.
    var isUppercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: true
        }
    }
}

extension Keyboard.KeyboardCase {

    var standardReleaseAction: KeyboardAction.GestureAction? {
        return { $0?.setKeyboardCase(standardReleaseCase) }
    }

    var standardReleaseCase: Self {
        switch self {
        case .lowercased: .uppercased
        default: .lowercased
        }
    }
}
