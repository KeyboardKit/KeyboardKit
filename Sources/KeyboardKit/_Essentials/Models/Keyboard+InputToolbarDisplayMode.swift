//
//  Keyboard+InputToolbarDisplayMode.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines input toolbar display modes, which
    /// can be used to set how an input toolbar is displayed.
    ///
    /// You can apply a display mode using the view modifier
    /// ``SwiftUICore/View/keyboardInputToolbarDisplayMode(_:)``.
    enum InputToolbarDisplayMode: Equatable {

        /// This mode renders an input toolbar when it makes
        /// sense given the current device and configuration.
        case automatic

        /// This mode can be used to display a set of inputs.
        case inputs(_ inputs: String)
        
        /// This mode can be used to hide the input toolbar.
        case hidden
    }
}

public extension Keyboard.InputToolbarDisplayMode {
    
    /// This mode can be used to display 1-0 as inputs.
    static let numbers = Self.inputs("1234567890")
}

public extension View {

    /// Apply an ``Keyboard/InputToolbarDisplayMode`` to the
    /// view hierarchy.
    func keyboardInputToolbarDisplayMode(
        _ style: Keyboard.InputToolbarDisplayMode
    ) -> some View {
        self.environment(\.keyboardInputToolbarDisplayMode, style)
    }
}

private extension Keyboard.InputToolbarDisplayMode {

    struct KeyboardKey: EnvironmentKey {
        static var defaultValue: Keyboard.InputToolbarDisplayMode = .automatic
    }
}

public extension EnvironmentValues {

    var keyboardInputToolbarDisplayMode: Keyboard.InputToolbarDisplayMode {
        get { self [Keyboard.InputToolbarDisplayMode.KeyboardKey.self] }
        set { self [Keyboard.InputToolbarDisplayMode.KeyboardKey.self] = newValue }
    }
}
