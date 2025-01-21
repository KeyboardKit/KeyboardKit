//
//  Keyboard+Case.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines various keyboard shift states.
    enum KeyboardCase: String, CaseIterable, Identifiable, KeyboardModel {

        case auto
        case capsLocked
        case lowercased
        case uppercased
    }
}

public extension Keyboard.KeyboardCase {
    
    var id: String { rawValue }
    
    /// Whether the case is uppercased or caps locked.
    var isUppercasedOrCapslocked: Bool {
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
