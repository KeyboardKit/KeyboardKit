//
//  Color+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 `IMPORTANT` The `KeyboardContext`s `userInterfaceStyle` has
 an incorrect state when `keyboardAppearance` is `.dark` and
 the device runs in `.light` mode. The keyboard will then be
 told that `userInterfaceStyle` is `dark` instead of `light`.
 This is WRONG, since dark keyboard appearance in light mode
 shouldn't look the same as any appearance in dark mode. You
 can see this bug in the SwiftUI demo app and start edit the
 text field that requires dark appearance. The keyboard will
 then apply dark mode colors, while the extension background
 (which is managed by the system) uses the dark appearance's
 background color.
 
 Bug info (also reported to Apple in Feedback Assistant):
 https://github.com/danielsaidi/KeyboardKit/issues/107
 */
public extension Color {
    
    /**
     The standard light background color in a system keyboard.
     */
    static func standardButton(for context: KeyboardContext) -> Color {
        context.useDarkAppearance ? .standardDarkAppearanceButton : .standardButton
    }
    
    /**
     The standard button tint color in a system keyboard.
     */
    static func standardButtonTint(for context: KeyboardContext) -> Color {
        context.useDarkAppearance ? .standardDarkAppearanceButtonTint : .standardButtonTint
    }
    
    /**
     The standard button shadow color in a system keyboard.
     */
    static func standardButtonShadowColor(for context: KeyboardContext) -> Color {
        .standardButtonShadow
    }
    
    /**
     The standard dark background color in a system keyboard.
     */
    static func standardDarkButton(for context: KeyboardContext) -> Color {
        context.useDarkAppearance ? .standardDarkAppearanceDarkButton : .standardDarkButton
    }
}

private extension KeyboardContext {
    
    var useDarkAppearance: Bool { colorScheme == .light && keyboardAppearance == .dark }
}
