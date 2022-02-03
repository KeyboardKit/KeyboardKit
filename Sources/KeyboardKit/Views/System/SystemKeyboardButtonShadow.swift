//
//  SystemKeyboardButtonShadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view represents the bottom shadow of a standard system
 keyboard button. Instead of being added as a shadow, it has
 to be added as an overlay, and will cut out the shadow that
 will be placed below the button shape.
 
 This makes it possible to have an opaque shadow, even for a
 button that has a semi-transparent color. This is needed to
 render the shadow properly for the dark mode bug workaround
 colors, which are semi-transparent in dark mode.
 */
public struct SystemKeyboardButtonShadow: View {
    
    /**
     Create a system keyboard button shadow view.
     
     - Parameters:
       - style: The button style to apply.
     */
    public init(style: KeyboardButtonStyle) {
        self.style = style
    }
    
    private let style: KeyboardButtonStyle
    
    public var body: some View {
        buttonShape
            .foregroundColor(style.shadow.color)
            .offset(y: style.shadow.size)
            .mask(buttonMask)
    }
}

private extension SystemKeyboardButtonShadow {
    
    var buttonMask: some View {
        GeometryReader {
            let frame = CGRect(origin: .zero, size: $0.size)
            let path: Path = {
                var path = Rectangle()
                    .inset(by: -style.shadow.size)
                    .path(in: frame)
                path.addPath(buttonShape.path(in: frame))
                return path
            }()
            path.fill(style: FillStyle(eoFill: true))
        }
    }
    
    var buttonShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: style.cornerRadius)
    }
}
