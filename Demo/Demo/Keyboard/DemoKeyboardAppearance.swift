//
//  DemoKeyboardAppearance.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
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

    // override var actionCalloutStyle: ActionCalloutStyle {
    //     var style = super.actionCalloutStyle()
    //     style.callout.backgroundColor = .red
    //     return style
    // }

    // override var inputCalloutStyle: InputCalloutStyle {
    //     var style = super.inputCalloutStyle()
    //     style.callout.backgroundColor = .blue
    //     style.callout.textColor = .yellow
    //     return style
    // }
}
