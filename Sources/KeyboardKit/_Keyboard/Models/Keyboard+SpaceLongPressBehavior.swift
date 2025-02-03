//
//  Keyboard+SpaceLongPressBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {
    
    /// This enum defines various space long press actions.
    enum SpaceLongPressBehavior: Codable {
        
        /// Long pressing space moves the input cursor.
        case moveInputCursor
        
        /// Long pressing space moves the input cursor. This
        /// case also adds a locale context menu to the view,
        /// when there are multiple enabled localed.
        case moveInputCursorWithLocaleSwitcher
        
        /// Long pressing space opens a locale context menu.
        case openLocaleContextMenu
    }
}

public extension Keyboard.SpaceLongPressBehavior {
    
    /// Whether space should add a trailing context menu.
    var shouldAddTrailingLocaleContextMenu: Bool {
        switch self {
        case .moveInputCursor: false
        case .moveInputCursorWithLocaleSwitcher: true
        case .openLocaleContextMenu: false
        }
    }
    
    /// Whether space should move the input cursor.
    var shouldMoveInputCursor: Bool {
        switch self {
        case .moveInputCursor: true
        case .moveInputCursorWithLocaleSwitcher: true
        case .openLocaleContextMenu: false
        }
    }
    
    /// Whether space should open a locale context menu.
    var shouldOpenLocaleContextMenu: Bool {
        switch self {
        case .moveInputCursor: false
        case .moveInputCursorWithLocaleSwitcher: false
        case .openLocaleContextMenu: true
        }
    }
}
