//
//  Keyboard+InputToolbarDisplayMode.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines input toolbar display modes, which
    /// can be used to set how an input toolbar is displayed.
    ///
    /// You can apply a display mode using the view modifier
    /// ``SwiftUICore/View/keyboardInputToolbarDisplayMode(_:)``.
    enum InputToolbarDisplayMode: Equatable {

        /// Display an input toolbar when it makes sense.
        case automatic

        /// Display a toolbar with a fix set of characters.
        case inputs(_ inputs: String)

        /// Display a toolbar with contextual numeric inputs.
        case numbers

        /// Hide the input toolbar.
        case hidden
    }
}

public extension View {

    /// Apply an ``Keyboard/InputToolbarDisplayMode``.
    func keyboardInputToolbarDisplayMode(
        _ mode: Keyboard.InputToolbarDisplayMode
    ) -> some View {
        self.environment(\.keyboardInputToolbarDisplayMode, mode)
    }
}

public extension EnvironmentValues {

    /// Apply an ``Keyboard/InputToolbarDisplayMode``.
    @Entry var keyboardInputToolbarDisplayMode = Keyboard
        .InputToolbarDisplayMode.automatic
}
