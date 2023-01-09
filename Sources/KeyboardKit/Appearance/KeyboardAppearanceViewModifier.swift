//
//  KeyboardAppearanceViewModifier.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view modifier can be used to set a keyboard appearance
 of a `TextField` or `TextEditor`, which controls if it will
 use a light or dark color scheme.

 Although this modifier is named like ``KeyboardAppearance``,
 it has nothing to do with keyboard styling, but rather aims
 to use the same name conventions as the `keyboardAppearance`
 properties of `UITextView` and `UITextField`.

 You can apply the modifier with `.keyboardAppearance(.dark)`
 to apply a dark keyboard appearance. Note that you must set
 `foregroundColor` before the modifier, if you want to use a
 custom text field/editor text color.
 */
public struct KeyboardAppearanceViewModifier: ViewModifier {

    /**
     The appearance to apply.
     */
    public init(appearance: ColorScheme) {
        self.appearance = appearance
    }

    /// The original color scheme
    @Environment(\.colorScheme)
    private var colorScheme

    /// The appearance to apply
    private let appearance: ColorScheme

    public func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .colorScheme(appearance)
    }
}

public extension View {

    /**
     Specify a keyboard appearance to apply when the view is
     being edited.
     */
    func keyboardAppearance(_ appearance: ColorScheme) -> some View {
        self.modifier(
            KeyboardAppearanceViewModifier(appearance: appearance)
        )
    }
}
