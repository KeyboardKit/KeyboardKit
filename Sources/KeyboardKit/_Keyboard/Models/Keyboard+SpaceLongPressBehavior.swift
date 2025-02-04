//
//  Keyboard+SpaceLongPressBehavior.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines various space long press behaviors.
    ///
    /// You can apply a custom value using the view modifier
    /// ``SwiftUICore/View/keyboardSpaceLongPressBehavior(_:)``.
    enum SpaceLongPressBehavior: String, CaseIterable, Identifiable, KeyboardModel {
        
        /// Long pressing space moves the input cursor.
        case moveInputCursor
        
        /// Long pressing space moves the input cursor, with
        /// an additional trailing locale context menu.
        case moveInputCursorWithLocaleSwitcher
        
        /// Long pressing space opens a locale context menu.
        case openLocaleContextMenu
    }
}

public extension Keyboard.SpaceLongPressBehavior {
    
    /// The unique behavior ID.
    var id: String { rawValue }
    
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

public extension View {

    /// Apply a ``Keyboard/SpaceLongPressBehavior`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/keyboardSpaceLongPressBehavior``.
    func keyboardSpaceLongPressBehavior(
        _ value: Keyboard.SpaceLongPressBehavior?
    ) -> some View {
        self.environment(\.keyboardSpaceLongPressBehavior, value)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Keyboard/SpaceLongPressBehavior`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/keyboardSpaceLongPressBehavior``.
    @Entry var keyboardSpaceLongPressBehavior: Keyboard.SpaceLongPressBehavior?
}

