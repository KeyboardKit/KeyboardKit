//
//  SystemKeyboardButtonShadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view renders the shadow of a system keyboard button.

 Instead of being added as a shadow, the view is added as an
 overlay then places a cut out shadow below the button shape.
 This makes it possible to have an opaque shadow, even for a
 button that has a semi-transparent color.

 This is needed to render the shadow correctly, even for the
 dark mode bug workaround colors, which are semi-transparent.
 */
public struct SystemKeyboardButtonShadow: View {
    
    /**
     Create a system keyboard button shadow view.

     This view uses a button style instead of a shadow style,
     since it must apply the proper corner radius.
     
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
