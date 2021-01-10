//
//  DemoKeyboardAppearanceProvider.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This provider inherits `StandardKeyboardAppearanceProvider`
 and adds demo-specific functionality to it.
 */
class DemoKeyboardAppearanceProvider: StandardKeyboardAppearanceProvider {
    
    override func text(for action: KeyboardAction, context: KeyboardContext) -> String? {
        switch action {
        case .space: return "space"
        default: return super.text(for: action, context: context)
        }
    }
}
