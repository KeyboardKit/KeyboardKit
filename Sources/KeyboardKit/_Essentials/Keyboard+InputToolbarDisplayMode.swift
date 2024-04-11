//
//  Keyboard+inputToolbarDisplayMode.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines input toolbar display modes, which
    /// can be used to add an input toolbar to e.g. a system
    /// keyboard component.
    ///
    /// You can apply a display mode using the view modifier
    /// ``SwiftUI/View/keyboardInputToolbarDisplayMode(_:)``.
    enum InputToolbarDisplayMode {
        case inputs(_ inputs: String)
        case hidden
        
        public static let automatic = Self.hidden
        public static let numbers = Self.inputs("1234567890")
    }
}

public extension View {

    /// Apply an ``Keyboard/InputToolbarDisplayMode`` to the
    /// view hierarchy.
    ///
    /// 👑 KeyboardKit Pro unlocks additional utilities that
    /// automatically injects toolbars into ``SystemKeyboard``
    /// when the display mode is set to present inputs.
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
