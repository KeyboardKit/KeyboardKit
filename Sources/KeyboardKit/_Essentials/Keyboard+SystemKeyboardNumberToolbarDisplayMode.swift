//
//  Keyboard+SystemKeyboardNumberToolbarDisplayMode.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This enum defines the system keyboard number toolbar
    /// display modes that are supported by the keyboard.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUI/View/systemKeyboardNumberToolbarDisplayMode(_:)``.
    enum SystemKeyboardNumberToolbarDisplayMode {
        case numbers(_ numbers: String? = nil)
        case hidden
        
        public static let automatic = Self.hidden
        public static let visible = Self.numbers()
    }
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarDisplayMode``.
    func systemKeyboardNumberToolbarDisplayMode(
        _ style: Keyboard.SystemKeyboardNumberToolbarDisplayMode
    ) -> some View {
        self.environment(\.systemKeyboardNumberToolbarDisplayMode, style)
    }
}

private extension Keyboard.SystemKeyboardNumberToolbarDisplayMode {

    struct Key: EnvironmentKey {
        static var defaultValue: Keyboard.SystemKeyboardNumberToolbarDisplayMode = .automatic
    }
}

public extension EnvironmentValues {

    var systemKeyboardNumberToolbarDisplayMode: Keyboard.SystemKeyboardNumberToolbarDisplayMode {
        get { self [Keyboard.SystemKeyboardNumberToolbarDisplayMode.Key.self] }
        set { self [Keyboard.SystemKeyboardNumberToolbarDisplayMode.Key.self] = newValue }
    }
}
