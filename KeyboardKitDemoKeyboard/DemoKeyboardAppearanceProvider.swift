//
//  DemoKeyboardAppearance.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This class inherits `StandardKeyboardAppearance` and adds a
 demo-specific layer on top of it.
 */
class DemoKeyboardAppearance: StandardKeyboardAppearance {
    
    override func font(for action: KeyboardAction) -> UIFont {
        switch action {
        case .space: return .preferredFont(forTextStyle: .body)
        default: return super.font(for: action)
        }
    }
    
    override func text(for action: KeyboardAction) -> String? {
        switch action {
        case .space: return "space"
        default: return super.text(for: action)
        }
    }
}
