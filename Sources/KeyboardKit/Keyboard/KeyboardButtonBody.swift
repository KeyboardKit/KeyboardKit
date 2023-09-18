//
//  KeyboardButtonBody.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders the body of a system keyboard button.

 The body is the button "background", which means the button
 shape, corner radius, shadow etc. without the content.
 */
public struct KeyboardButtonBody: View {

    /**
     Create a keyboard button body view.

     - Parameters:
       - style: The button style to apply.
       - isPressed: Whether or not the button is pressed, by default `false`.
     */
    public init(
        style: Style,
        isPressed: Bool = false
    ) {
        self.style = style
        self.isPressed = isPressed
    }
    
    public typealias Style = KeyboardStyle.Button

    private let style: Style
    private let isPressed: Bool

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(borderColor, lineWidth: borderLineWidth)
            .background(backgroundColor)
            .overlay(isPressed ? style.pressedOverlayColor : .clear)
            .cornerRadius(cornerRadius)
            .overlay(SystemKeyboardButtonShadow(style: style))
    }
}

public extension KeyboardButtonBody {

    var backgroundColor: Color { style.backgroundColor ?? .clear }

    var borderColor: Color { style.border?.color ?? .clear }

    var borderLineWidth: CGFloat { style.border?.size ?? 0 }

    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
}

struct KeyboardButtonBody_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            KeyboardButtonBody(style: .preview1)
            KeyboardButtonBody(style: .preview2)
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .environment(\.sizeCategory, .extraExtraLarge)
    }
}
