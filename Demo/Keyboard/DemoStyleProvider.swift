//
//  DemoStyleProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2022-12-21.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific provider inherits the standard one, then
 makes the rocket button font larger.
 
 There's a bunch of disabled code that you can enable to see
 how the style of the keyboard changes.
 */
class DemoStyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonFontSize(
        for action: KeyboardAction
    ) -> CGFloat {
        let standard = super.buttonFontSize(for: action)
        return action.isRocket ? 1.8 * standard : standard
    }
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        if action.isRocket {
            return super.buttonStyle(for: .backspace, isPressed: isPressed)
        }
        return super.buttonStyle(for: action, isPressed: isPressed)
    }
    
    // override func buttonImage(for action: KeyboardAction) -> Image? {
    //     if action == .keyboardType(.emojis) { return nil }
    //     return super.buttonImage(for: action)
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

private extension KeyboardAction {
    
    var isRocket: Bool {
        switch self {
        case .character(let char): return char == "🚀"
        default: return false
        }
    }
}
