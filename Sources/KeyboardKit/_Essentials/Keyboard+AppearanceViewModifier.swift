//
//  Keyboard+AppearanceViewModifier.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /**
     This view modifier can be used to apply a light or dark
     keyboard appearance to a text input.
     
     You can apply the `.keyboardAppearance(.dark)` modifier
     to a view, instead of creating a full modifier instance.
     
     To set the text color of the modifier text field/editor,
     you must apply a `foregroundColor` before this modifier.
     */
    struct AppearanceViewModifier: ViewModifier {
        
        public init(_ appearance: ColorScheme) {
            self.appearance = appearance
        }
        
        @Environment(\.colorScheme)
        private var colorScheme
        
        private let appearance: ColorScheme
        
        public func body(content: Self.Content) -> some View {
            content
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .colorScheme(appearance)
        }
    }
}

public extension View {

    /**
     This view modifier can be used to apply a light or dark
     keyboard appearance to a text input.
     
     To set the text color of the modifier text field/editor,
     you must apply a `foregroundColor` before this modifier.
     */
    func keyboardAppearance(_ appearance: ColorScheme) -> some View {
        self.modifier(
            Keyboard.AppearanceViewModifier(appearance)
        )
    }
}
