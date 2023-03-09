//
//  DemoKeyboardAppearance.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 customizes the look of the keyboard.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom keyboard appearance.

 Just comment out any of the functions below to override any
 part of the standard appearance.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {

    /**
     This font adjustment is actually not needed anymore. It
     has already been added to the main library. However, it
     is still here to show how you can adjust the appearance.
     */
    override func buttonFont(for action: KeyboardAction) -> Font {
        let base = super.buttonFont(for: action)
        guard
            keyboardContext.keyboardType.isAlphabetic,
            keyboardContext.locale == KeyboardLocale.georgian.locale
        else { return base }
        return base.weight(.regular)
    }
}
