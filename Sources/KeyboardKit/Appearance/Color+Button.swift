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
 
 `IMPORTANT` The KeyboardContext `colorScheme` becomes wrong
 when `keyboardAppearance` is `.dark` and the device runs in
 `.light` mode. The keyboard extension will be told that the
 colorScheme is `.dark` instead of `.light`.

 This is WRONG, since "dark appearance" keyboards should NOT
 look the same in light mode and dark mode. However, this is
 how iOS sets up the extension and not a bug in KeyboardKit.
 
 Until this is fixed, set the `Color.darkAppearanceStrategy`
 to a custom strategy if you want to customize KeyboardKit's
 standard strategy of always applying dark appearance colors
 when dark mode is enabled.
 
 Issue report (also reported to Apple in Feedback Assistant):
 https://github.com/danielsaidi/KeyboardKit/issues/305
 */
public extension Color {
    
    /**
     The standard background color of light keys in a system
     keyboard.
     */
    static func standardButtonBackgroundColor(for context: KeyboardContext) -> Color {
        darkAppearanceStrategy(context) ? .standardButtonBackgroundForDarkAppearance : .standardButtonBackground
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
        darkAppearanceStrategy(context) ? .standardDarkButtonBackgroundForDarkAppearance : .standardDarkButtonBackground
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
