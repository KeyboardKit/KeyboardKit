//
//  Keyboard+AppearanceViewModifier.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    @available(*, deprecated, message: "This will be removed in KeyboardKit 9")
    struct AppearanceViewModifier: ViewModifier {
        
        public init(
            _ appearance: ColorScheme,
            foregroundColor: Color? = nil
        ) {
            self.appearance = appearance
            self.foregroundColor = foregroundColor
        }
        
        @Environment(\.colorScheme)
        private var colorScheme

        private let appearance: ColorScheme
        private let foregroundColor: Color?

        public func body(content: Self.Content) -> some View {
            content
                .foregroundColor(foregroundColorToUse)
                .colorScheme(appearance)
        }

        var foregroundColorToUse: Color {
            if let foregroundColor { return foregroundColor }
            return colorScheme == .dark ? .white : .black
        }
    }
}

@available(*, deprecated, message: "This will be removed in KeyboardKit 9")
public extension View {

    func keyboardAppearance(
        _ appearance: ColorScheme,
        foregroundColor: Color? = nil
    ) -> some View {
        self.modifier(
            Keyboard.AppearanceViewModifier(appearance)
        )
    }
}
