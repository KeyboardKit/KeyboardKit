//
//  SystemKeyboardButtonBody.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view represents the body of a standard system keyboard
 button, excluding the button text or image.
 */
public struct SystemKeyboardButtonBody: View {
    
    /**
     Create a system keyboard button body view.
     
     - Parameters:
       - style: The button style to apply.
     */
    public init(style: SystemKeyboardButtonStyle) {
        self.style = style
    }
    
    private let style: SystemKeyboardButtonStyle
    
    public var body: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius)
            .strokeBorder(style.border.color, lineWidth: style.border.size)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRadius)
            .overlay(SystemKeyboardButtonShadow(style: style))
    }
}

struct SystemKeyboardButtonBody_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            SystemKeyboardButtonBody(style: .preview1)
            SystemKeyboardButtonBody(style: .preview2)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
        .keyboardPreview()
    }
}
