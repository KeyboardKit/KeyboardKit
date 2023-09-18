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
            .overlay(Shadow(style: style))
    }
}

public extension KeyboardButtonBody {
    
    /**
     This view renders the round shadow of a keyboard button.
     
     Instead of being a real shadow, this view is an overlay
     that makes it possible to have opaque shadows, even for
     buttons that have a semi-transparent color.
     
     This is needed to render the shadow correctly, even for
     dark mode bug workaround colors, which are semi-opaque.
     */
    struct Shadow: View {
        
        /**
         Create a system keyboard button shadow view.

         This view uses a button style instead of a shadow style,
         since it must apply the proper corner radius.
         
         - Parameters:
           - style: The button style to apply.
         */
        public init(style: Style) {
            self.style = style
        }
        
        public typealias Style = KeyboardStyle.Button
        
        private let style: Style
        
        public var body: some View {
            buttonShape
                .foregroundColor(shadowColor)
                .offset(y: shadowSize)
                .mask(buttonMask)
        }
    }
}

public extension KeyboardButtonBody {

    var backgroundColor: Color { style.backgroundColor ?? .clear }

    var borderColor: Color { style.border?.color ?? .clear }

    var borderLineWidth: CGFloat { style.border?.size ?? 0 }

    var cornerRadius: CGFloat { style.cornerRadius ?? 0 }
}

private extension KeyboardButtonBody.Shadow {

    var buttonMask: some View {
        GeometryReader {
            let frame = CGRect(origin: .zero, size: $0.size)
            let path: Path = {
                var path = Rectangle()
                    .inset(by: -shadowSize)
                    .path(in: frame)
                path.addPath(buttonShape.path(in: frame))
                return path
            }()
            path.fill(style: FillStyle(eoFill: true))
        }
    }
    
    var buttonShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: shadowCornerRadius)
    }
    
    var shadowColor: Color {
        style.shadow?.color ?? .clear
    }

    var shadowCornerRadius: CGFloat {
        style.cornerRadius ?? 0
    }

    var shadowSize: CGFloat {
        style.shadow?.size ?? 0
    }
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
