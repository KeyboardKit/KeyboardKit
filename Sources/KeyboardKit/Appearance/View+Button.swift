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
        let style = SystemKeyboardButtonBodyStyle(
            buttonColor: appearance.buttonBackgroundColor(for: action, isPressed: isPressed),
            cornerRadius: appearance.buttonCornerRadius(for: action),
            shadowColor: appearance.buttonShadowColor(for: action),
            shadowHeight: 1)
        return self.background(SystemKeyboardButtonBody(style: style))
            .foregroundColor(appearance.buttonForegroundColor(for: action, isPressed: isPressed))
            .font(appearance.buttonFont(for: action))
    }
}

struct View_Button_Previews: PreviewProvider {
    
    static func button(for action: KeyboardAction) -> some View {
        SystemKeyboardButton(
            action: action,
            actionHandler: PreviewKeyboardActionHandler(),
            appearance: PreviewKeyboardAppearance()) {
                $0.padding()
            }
    }
    
    static var previews: some View {
        VStack {
            button(for: .character("a"))
            button(for: .character("A"))
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
    }
}
