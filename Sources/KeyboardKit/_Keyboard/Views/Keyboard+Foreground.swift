//
//  Keyboard+Foreground.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-17.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension EnvironmentValues {

    /// Apply a keyboard foreground color.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardStyleService/foregroundColor``.
    @Entry var keyboardForeground: Color?
}

public extension View {

    /// Apply a keyboard background style.
    ///
    /// ``KeyboardView`` will use this value, if any, or the
    /// ``KeyboardStyleService/foregroundColor``.
    func keyboardForeground(
        _ color: Color
    ) -> some View {
        self.environment(\.keyboardForeground, color)
    }
}
