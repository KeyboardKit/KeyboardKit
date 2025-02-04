//
//  Keyboard+InputToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines various input toolbar modes, which
    /// can be used to set how an input toolbar is displayed.
    ///
    /// You can apply a custom value using the view modifier
    /// ``SwiftUICore/View/keyboardInputToolbarDisplayMode(_:)``.
    enum InputToolbarDisplayMode: KeyboardModel {

        /// Display a toolbar based on the native behavior.
        case automatic

        /// Display a fixed set of characters.
        case characters(_ inputs: [String])

        /// Display contextual numbers or symbols.
        case numbers

        /// Remove the input toolbar altogether.
        case none
    }
}

public extension Keyboard.InputToolbarDisplayMode {
    
    /// Display a fixed set of characters.
    static func characters(_ inputs: String) -> Self {
        .characters(inputs.chars)
    }
}

public extension View {

    /// Apply an ``Keyboard/InputToolbarDisplayMode`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/inputToolbarDisplayMode``.
    func keyboardInputToolbarDisplayMode(
        _ value: Keyboard.InputToolbarDisplayMode
    ) -> some View {
        self.environment(\.keyboardInputToolbarDisplayMode, value)
    }
}

public extension EnvironmentValues {

    /// Apply an ``Keyboard/InputToolbarDisplayMode`` value.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardSettings/inputToolbarDisplayMode``.
    @Entry var keyboardInputToolbarDisplayMode: Keyboard
        .InputToolbarDisplayMode?
}
