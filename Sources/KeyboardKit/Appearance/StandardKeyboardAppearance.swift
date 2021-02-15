//
//  StandardKeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This standard appearance returns a style that mimics native
 system keyboards.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
    open var keyboardBackgroundColor: Color { .clear }
    
    open func buttonBackgroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.standardButtonBackgroundColor(for: context, isPressed: isPressed)
    }
    
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat { 4.0 }
    
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = Font(action.standardButtonFont)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    open func buttonForegroundColor(for action: KeyboardAction, isPressed: Bool) -> Color {
        action.standardButtonForegroundColor(for: context, isPressed: isPressed)
    }
    
    open func buttonImage(for action: KeyboardAction) -> Image? {
        action.standardButtonImage
    }
    
    open func buttonShadowColor(for action: KeyboardAction) -> Color {
        action.standardButtonShadowColor(for: context)
    }
    
    open func buttonText(for action: KeyboardAction) -> String? {
        action.standardButtonText
    }
}

private extension StandardKeyboardAppearance {
    
    func fontWeight(for action: KeyboardAction) -> UIFont.Weight? {
        if buttonImage(for: action) != nil { return .light }
        return action.standardButtonFontWeight
    }
}

struct StandardKeyboardAppearance_Previews: PreviewProvider {
    
    static var context = ObservableKeyboardContext.preview
    static var appearance = StandardKeyboardAppearance(context: context)
    
    static var actions: [KeyboardAction] = [
        .character(""),
        .space,
        .ok,
        .go]
    
    static func view(for action: KeyboardAction) -> some View {
        Text("A")
            .padding()
            .font(.title)
            .keyboardButtonStyle(for: action, appearance: appearance, isPressed: false)
            .padding()
    }
    
    static var previews: some View {
        Group {
            ForEach(Array(actions.enumerated()), id: \.offset) { action in
                HStack(spacing: 0) {
                    view(for: action.element)
                    view(for: action.element).background(Color.black).colorScheme(.dark)
                }
            }
        }.previewLayout(.sizeThatFits)
    }
}
