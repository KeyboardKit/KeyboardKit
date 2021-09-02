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
 keyboard with the `keyboardAppearance` set to `.dark`. This
 will set the `colorScheme` of the extesion to `.dark`, even
 if the system uses `.light`.
 
 To work around this bug, the button background colors use a
 temporary color set with the suffix `ForColorSchemeBug`. It
 uses dark mode colors that are semi-transparent white, with
 an opacity that makes them look good in both light mode and
 dark appearance and dark mode.
 
 For now, we also have a `Color.darkAppearanceStrategy` that
 makes it possible to customize whether or not to use colors
 for dark appearance.
 
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
        darkAppearanceStrategy(context) ? .standardButtonBackgroundForColorSchemeBug : .standardDarkButtonBackground
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
     
     You can register a custom `Color.darkAppearanceStrategy`
     to control when the dark appearance colors should apply.
     By default, the dark appearance colors when the context
     `colorScheme` is `.dark`, since that looks a lot better
     than when dark mode colors are used for dark appearance
     keyboards in light mode.
     */
    typealias DarkAppearanceStrategy = (KeyboardContext) -> Bool
    
    /**
     This is a temporary typealias that is needed as long as
     iOS keyboard extensions are unable to differ between if
     dark mode is enabled or a dark appearance text field is
     being edited, as described in `Color+Button`.
     
     You can register a custom `Color.darkAppearanceStrategy`
     to control when the dark appearance colors should apply.
     By default, the dark appearance colors when the context
     `colorScheme` is `.dark`, since that looks a lot better
     than when dark mode colors are used for dark appearance
     keyboards in light mode.
     */
    static var darkAppearanceStrategy: DarkAppearanceStrategy = {
        // This is how we want things to work...
        // $0.colorScheme == .light && $0.keyboardAppearance == .dark
        
        // ...but according to the bug above, we go with the
        // dark appearance look for both dark appearance and
        // dark mode.
        $0.colorScheme == .dark
    }
}
