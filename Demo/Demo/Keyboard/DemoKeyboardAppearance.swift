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

 ``KeyboardViewController`` registers it to show how you can
 register and use a custom keyboard appearance.

 Just comment out any of the functions below to override any
 part of the standard appearance.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    
    // override func actionCalloutStyle() -> ActionCalloutStyle {
    //     var style = super.actionCalloutStyle()
    //     style.callout.backgroundColor = .red
    //     return style
    // }

    // override func buttonImage(for action: KeyboardAction) -> Image? {
    //     if action == .keyboardType(.emojis) { return nil }
    //     return super.buttonImage(for: action)
    // }

    // override func buttonStyle(
    //     for action: KeyboardAction,
    //     isPressed: Bool
    // ) -> KeyboardButtonStyle {
    //     var style = super.buttonStyle(for: action, isPressed: isPressed)
    //     style.cornerRadius = 10
    //     style.backgroundColor = .blue
    //     style.foregroundColor = .yellow
    //     return style
    // }

    // override func buttonText(for action: KeyboardAction) -> String? {
    //     if action == .return { return "⏎" }
    //     if action == .space { return "" }
    //     if action == .keyboardType(.emojis) { return "🤯" }
    //     return super.buttonText(for: action)
    // }

    // override func inputCalloutStyle() -> InputCalloutStyle {
    //     var style = super.inputCalloutStyle()
    //     style.callout.backgroundColor = .blue
    //     style.callout.textColor = .yellow
    //     return style
    // }
}
