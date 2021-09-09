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
            let style = appearance.systemKeyboardButtonStyle(for: action, isPressed: isPressed)
            return self
                .background(SystemKeyboardButtonBody(style: style))
                .foregroundColor(style.foregroundColor)
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
