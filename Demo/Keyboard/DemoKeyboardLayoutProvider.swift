//
//  DemoKeyboardLayoutProvider.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-19.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo-specific layout provider appends a language picker button next to
 the space bar.
 */
class DemoKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func actions(for context: KeyboardContext, inputs: KeyboardInputRows) -> KeyboardActionRows {
        var actions = super.actions(for: context, inputs: inputs)
        var last = actions[actions.count - 1]
        _ = actions.dropLast()
        last.insert(.nextLocale, at: actions.count - 2)
        actions.append(last)
        return actions
    }
}
