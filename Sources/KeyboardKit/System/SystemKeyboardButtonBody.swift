//
//  SystemKeyboardButtonBody.swift
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
public struct SystemKeyboardButtonBody: View {
    
    /**
     Create a system keyboard button body view.
     
     - Parameters:
       - style: The button style to apply.
     */
    public init(style: KeyboardButtonStyle) {
        self.style = style
    }
    
    private let style: KeyboardButtonStyle
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(borderColor, lineWidth: borderLineWidth)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(SystemKeyboardButtonShadow(style: style))
    }
}

public extension SystemKeyboardButtonBody {

    var backgroundColor: Color { style.backgroundColor ?? .clear }

    var borderColor: Color { style.border?.color ?? .clear }

    var borderLineWidth: CGFloat { style.border?.size ?? 0 }

    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
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
    }
}
