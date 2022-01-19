//
//  Color+ButtonTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This file contains keyboard-specific color extensions.
 
 These contextual colors may appear to be resolved in a very
 strange way, but the reason is that iOS currently has a bug
 that cause `colorScheme` to become incorrect when editing a
 keyboard with `keyboardAppearance` set to `dark`. This will
 set the `colorScheme` of the extension to `dark`, even when
 the system is `light`.
 
 To work around this bug, the button background colors use a
 temporary color set with the suffix `ForColorSchemeBug`. It
 uses dark mode colors that are semi-transparent white, with
 an opacity that makes them look good in both light mode and
 dark appearance and dark mode.
 
 For now, the `Color.darkAppearanceStrategy` property can be
 used to customize whether or not to use dark appearance.
 
 Issue report (also reported to Apple in Feedback Assistant):
 https://github.com/danielsaidi/KeyboardKit/issues/305
 */
public extension Color {
    
    /**
     The standard background color of light keys in a system
     keyboard.
     */
    static func standardButtonBackgroundColor(for context: KeyboardContext) -> Color {
        darkAppearanceStrategy(context) ? .standardButtonBackgroundForColorSchemeBug : .standardButtonBackground
    }
    
    /**
     The standard foreground color of light keys in a system
     keyboard.
     */
    static func standardButtonForegroundColor(for context: KeyboardContext) -> Color {
        darkAppearanceStrategy(context) ? .standardButtonForegroundForDarkAppearance : .standardButtonForeground
    }
    
    /**
     The standard button shadow color in a system keyboard.
     */
    static func standardButtonShadowColor(for context: KeyboardContext) -> Color {
        .standardButtonShadow
    }
    
    /**
     The standard background color of a dark key in a system
     keyboard.
     */
    static func standardDarkButtonBackgroundColor(for context: KeyboardContext) -> Color {
        darkAppearanceStrategy(context) ? .standardDarkButtonBackgroundForColorSchemeBug : .standardDarkButtonBackground
    }
    
    /**
     The standard foreground color of a dark key in a system
     keyboard.
     */
    static func standardDarkButtonForegroundColor(for context: KeyboardContext) -> Color {
        darkAppearanceStrategy(context) ? .standardDarkButtonForegroundForDarkAppearance : .standardDarkButtonForeground
    }
}

public extension Color {
    
    /**
     This is a temporary typealias that is needed as long as
     iOS keyboard extensions are unable to differ between if
     dark mode is enabled or a dark appearance text field is
     being edited, as described in `Color+Button`.
     */
    typealias DarkAppearanceStrategy = (KeyboardContext) -> Bool
    
    /**
     This is a temporary property that is used to control if
     dark appearance should be applied or not. You can set a
     custom strategy if you want, but it shouldn't be needed.
     */
    static var darkAppearanceStrategy: DarkAppearanceStrategy = {
        // This is how we want things to work...
        // $0.colorScheme == .light && $0.keyboardAppearance == .dark
        // ...but according to the bug above, we go with the
        // dark appearance look for both dark appearance and
        // dark mode.
        $0.hasDarkColorScheme
    }
}
