//
//  Keyboard+SpaceAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-02-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines extra actions that can be added to
    /// the spacebar.
    ///
    /// You can add a trailing action with the view modifier
    /// ``SwiftUICore/View/keyboardSpaceTrailingAction(_:)``.
    enum SpaceAction: String, CaseIterable, Identifiable, KeyboardModel {
        
        /// Add a trailing locale context menu.
        case localeContextMenu
    }
}

public extension Keyboard.SpaceAction {
    
    /// The unique behavior ID.
    var id: String { rawValue }
}

public extension View {

    /// Apply a trailing ``Keyboard/SpaceAction``.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/spaceTrailingAction``.
    func keyboardSpaceTrailingAction(
        _ value: Keyboard.SpaceAction?
    ) -> some View {
        self.environment(\.keyboardSpaceTrailingAction, value)
    }
}

public extension EnvironmentValues {

    /// Apply a trailing ``Keyboard/SpaceAction``.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/spaceTrailingAction``.
    @Entry var keyboardSpaceTrailingAction: Keyboard.SpaceAction?
}
