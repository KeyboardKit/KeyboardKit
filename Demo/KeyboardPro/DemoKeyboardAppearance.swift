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

//    override func buttonText(for action: KeyboardAction) -> String? {
//        switch action {
//        case .primary: return "🍭"
//        default: return super.buttonText(for: action)
//        }
//    }
//
//    override func buttonStyle(
//        for action: KeyboardAction,
//        isPressed: Bool
//    ) -> KeyboardButtonStyle {
//        var style = super.buttonStyle(for: action, isPressed: isPressed)
//        style.cornerRadius = 10
//        style.border = .init(color: .white, size: 2)
//        style.backgroundColor = action.isSystemAction ? .cottonPink : .cottonBlue
//        style.foregroundColor = .cottonRed
//        return style
//    }
}
