//
//  View+SystemKeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply a system keyboard button style using the provided
     `appearance` for the given `action`.
     */
    func systemKeyboardButtonStyle(_ style: SystemKeyboardButtonStyle) -> some View {
        self.background(SystemKeyboardButtonBody(style: style))
            .foregroundColor(style.foregroundColor)
            .font(style.font)
    }
}

struct View_Button_Previews: PreviewProvider {
    
    static func button<Content: View>(for content: Content) -> some View {
        content
            .padding()
            .systemKeyboardButtonStyle(.preview1)
    }
    
    static var previews: some View {
        VStack {
            button(for: Text("a"))
            button(for: Text("A"))
            button(for: Image.keyboardGlobe)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
