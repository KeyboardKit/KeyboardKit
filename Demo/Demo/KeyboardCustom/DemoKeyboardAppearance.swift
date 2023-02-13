//
//  DemoKeyboardAppearance.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-10-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific appearance inherits the standard one and
 can be used to customize the demo keyboard.

 ``KeyboardViewController`` registers this class to show you
 how you can set up a custom keyboard appearance.

 This appearance basically just performs a couple of changes
 to show how easy it is to customize the style of a keyboard.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        if action == .keyboardType(.emojis) { return nil }
        return super.buttonImage(for: action)
    }

     override func buttonStyle(
         for action: KeyboardAction,
         isPressed: Bool
     ) -> KeyboardButtonStyle {
         var style = super.buttonStyle(for: action, isPressed: isPressed)
         style.cornerRadius = 15
         style.backgroundColor = action.isSystemAction ? .yellow : .blue
         style.foregroundColor = action.isSystemAction ? .blue : .yellow
         return style
     }

     override func buttonText(for action: KeyboardAction) -> String? {
         if action == .keyboardType(.emojis) { return "🤯" }
         return super.buttonText(for: action)
     }

     override var actionCalloutStyle: ActionCalloutStyle {
         var style = super.actionCalloutStyle
         style.callout.backgroundColor = .red
         return style
     }

     override var inputCalloutStyle: InputCalloutStyle {
         var style = super.inputCalloutStyle
         style.callout.backgroundColor = .blue
         style.callout.textColor = .yellow
         return style
     }
}
