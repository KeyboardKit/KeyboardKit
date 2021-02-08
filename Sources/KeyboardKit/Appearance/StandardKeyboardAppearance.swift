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
 
 `TODO` Unit test.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init(context: KeyboardContext) {
        self.context = context
    }
    
    private let context: KeyboardContext
    
    open func buttonBackgroundColor(for action: KeyboardAction) -> Color {
        if action.isPrimaryAction { return .blue }
        return action.standardButtonBackgroundColor(for: context)
    }
    
    open func buttonCornerRadius(for action: KeyboardAction) -> CGFloat { 4.0 }
    
    open func buttonFont(for action: KeyboardAction) -> Font {
        let rawFont = Font(action.standardButtonFont)
        guard let weight = fontWeight(for: action) else { return rawFont }
        return rawFont.weight(weight)
    }
    
    open func buttonForegroundColor(for action: KeyboardAction) -> Color {
        if action.isPrimaryAction { return .white }
        return action.standardButtonForegroundColor(for: context)
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
        let hasImage = buttonImage(for: action) != nil
        return hasImage ? .light : nil
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
            .keyboardButtonStyle(for: action, appearance: appearance)
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
