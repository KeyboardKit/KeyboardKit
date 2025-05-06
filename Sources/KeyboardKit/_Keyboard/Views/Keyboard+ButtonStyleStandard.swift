//
//  Keyboard+ButtonStyleStandard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-05-06.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard.ButtonStyle {

    /// The standard keyboard button style to use.
    static func standard(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        fatalError()
    }
}

public extension Keyboard.ButtonStyleBuilderParams {

    /// The standard callout actions to use for the provided
    /// keyboard context.
    func standardButtonStyle(
        for context: KeyboardContext
    ) -> Keyboard.ButtonStyle {
        .standard(for: action, context: context)
    }
}

public extension Keyboard.ButtonStyle {

}
