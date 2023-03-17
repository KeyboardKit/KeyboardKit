//
//  DemoKeyboardAppearance.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

extension Color {

    static func custom(r: Int, g: Int, b: Int) -> Color {
        Color(red: Double(r)/255.0, green: Double(g)/255.0, blue: Double(b)/255.0)
    }

    static var cottonBackground = Color.custom(r: 254, g: 219, b: 214)
    static var cottonPink = Color.custom(r: 238, g: 202, b: 254)
    static var cottonBlue = Color.custom(r: 201, g: 240, b: 255)
    static var cottonRed = Color.custom(r: 189, g: 61, b: 104)
}

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
