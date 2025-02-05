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
        
        /// Long pressing space opens a locale context menu.
        case openLocaleContextMenu
    }
}

public extension Keyboard.SpaceLongPressBehavior {
    
    /// The unique behavior ID.
    var id: String { rawValue }
}

public extension View {

    /// Apply a ``Keyboard/SpaceLongPressBehavior`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/spaceLongPressBehavior``.
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
    /// ``KeyboardSettings/spaceLongPressBehavior``.
    @Entry var keyboardSpaceLongPressBehavior: Keyboard.SpaceLongPressBehavior?
}
