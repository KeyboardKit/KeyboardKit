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
        appearance: KeyboardAppearance) -> some View {
        self.background(appearance.buttonBackgroundColor(for: action))
            .foregroundColor(appearance.buttonForegroundColor(for: action))
            .cornerRadius(appearance.buttonCornerRadius(for: action))
            .shadow(color: appearance.buttonShadowColor(for: action), radius: 0, x: 0, y: 1)
            .font(appearance.buttonFont(for: action))
    }
    
}
