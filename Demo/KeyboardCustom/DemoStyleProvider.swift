//
//  DemoStyleProvider.swift
//  KeyboardCustom
//
//  Created by Daniel Saidi on 2022-09-02.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific style provider inherits the standard one
 and can be used to customize the demo keyboard style.
 
 ``KeyboardViewController`` registers this class to show you
 how to set up a custom keyboard style provider.
 
 This provider just performs a couple of changes to show how
 easy it is to customize the style of a keyboard.
 */
class DemoStyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonImage(for action: KeyboardAction) -> Image? {
        if action == .keyboardType(.emojis) { return nil }
        return super.buttonImage(for: action)
    }
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
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
    
    override var actionCalloutStyle: KeyboardStyle.ActionCallout {
        var style = super.actionCalloutStyle
        style.callout.backgroundColor = .blue
        style.callout.textColor = .yellow
        style.selectedBackgroundColor = .black.opacity(0.2)
        return style
    }
    
    override var inputCalloutStyle: KeyboardStyle.InputCallout {
        var style = super.inputCalloutStyle
        style.callout.backgroundColor = .blue
        style.callout.textColor = .yellow
        return style
    }
}
