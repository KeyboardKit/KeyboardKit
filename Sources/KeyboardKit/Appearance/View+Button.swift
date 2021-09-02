//
//  View+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a keyboard button appearance to the view.
     */
    func keyboardButtonStyle(
        for action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Bool = false) -> some View {
        self.background(keyboardButtonBackground(for: action, appearance: appearance, isPressed: isPressed))
            .foregroundColor(appearance.buttonForegroundColor(for: action, isPressed: isPressed))
            .font(appearance.buttonFont(for: action))
    }
}

private extension View {
    
    func keyboardButtonBackground(
        for action: KeyboardAction,
        appearance: KeyboardAppearance,
        isPressed: Bool = false) -> some View {
        appearance
            .buttonBackgroundColor(for: action, isPressed: isPressed)
            .cornerRadius(appearance.buttonCornerRadius(for: action))
            .shadow(color: appearance.buttonShadowColor(for: action), radius: 0, x: 0, y: 1)
    }
}
