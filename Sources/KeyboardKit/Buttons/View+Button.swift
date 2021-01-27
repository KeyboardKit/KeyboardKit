//
//  View+Button.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply the standard button style, including a background,
     foreground color, corner radius, shadow and font.
     */
    func standardButtonStyle(
        for action: KeyboardAction,
        context: KeyboardContext,
        cornerRadius: CGFloat = 4.0) -> some View {
        self.standardButtonBackground(for: action, context: context)
            .standardButtonForeground(for: context)
            .cornerRadius(cornerRadius)
            .standardButtonShadow(for: context)
            .standardButtonFont(for: action, context: context)
    }
    
    /**
     Apply a standard button background.
     */
    func standardButtonBackground(for action: KeyboardAction, context: KeyboardContext) -> some View {
        background(action.standardButtonBackgroundColor(for: context))
    }
    
    /**
     Apply a standard button font.
     */
    func standardButtonFont(for action: KeyboardAction, context: KeyboardContext) -> some View {
        let provider = context.keyboardAppearanceProvider
        let rawFont = provider.font(for: action)
        if let weight = provider.fontWeight(for: action, context: context) { return font(rawFont.weight(weight)) }
        let hasImage = action.standardButtonImage(for: context) != nil
        return hasImage ? font(rawFont.weight(.light)) : font(rawFont)
    }
    
    /**
     Apply a standard button foreground color.
     */
    func standardButtonForeground(for context: KeyboardContext) -> some View {
        foregroundColor(.standardButtonTint(for: context))
    }
    
    /**
     Apply a standard button shadow.
     */
    func standardButtonShadow(for context: KeyboardContext) -> some View {
        let color = Color.standardButtonShadowColor(for: context)
        return self.shadow(color: color, radius: 0, x: 0, y: 1)
    }
}
