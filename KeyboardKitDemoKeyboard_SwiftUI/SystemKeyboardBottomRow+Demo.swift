//
//  SystemKeyboardBottomRow+Demo.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-07-14.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI

extension SystemKeyboardBottomRow {
    
    static func demoRow(for context: KeyboardContext) -> SystemKeyboardBottomRow {
        let left = demoRowLeftmostAction(for: context)
        let right: KeyboardAction = context.needsInputModeSwitchKey ? .keyboardType(.emojis) : .keyboardType(.images)
        return SystemKeyboardBottomRow(
            leftmostActions: SystemKeyboardBottomRow.standardLeftmostActions(for: context, leftAction: left),
            rightmostActions: [right, .newLine])
    }
    
    static func demoRowLeftmostAction(for context: KeyboardContext) -> KeyboardAction {
        switch context.keyboardType {
        case .alphabetic: return .keyboardType(.numeric)
        default: return .keyboardType(.alphabetic(.lowercased))
        }
    }
}
