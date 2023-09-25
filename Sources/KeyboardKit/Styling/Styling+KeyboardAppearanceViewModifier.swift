//
//  KeyboardAppearanceViewModifier.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Styling {
    
    /**
     This view modifier can be used to apply a light or dark
     keyboard appearance to a text input.
     
     You can apply the `.keyboardAppearance(.dark)` modifier
     to a view, instead of creating a full modifier instance.
     
     To set the text color of the modifier text field/editor,
     you must apply a `foregroundColor` before this modifier.
     */
    struct KeyboardAppearanceViewModifier: ViewModifier {
        
        public init(appearance: ColorScheme) {
            self.appearance = appearance
        }
        
        @Environment(\.colorScheme)
        private var colorScheme
        
        private let appearance: ColorScheme
        
        public func body(content: Content) -> some View {
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
            Styling.KeyboardAppearanceViewModifier(appearance: appearance)
        )
    }
}
