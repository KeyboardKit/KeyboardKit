//
//  KeyboardButton+Shadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /**
     This view renders the round shadow of a keyboard button.
     
     Instead of being a real shadow, this view is an overlay
     that lets us use opaque shadows for transparent buttons.
     
     This is needed to render the shadow correctly, even for
     dark mode bug workaround colors, which are semi-opaque.
     */
    struct Shadow: View {
        
        /**
         Create a keyboard button shadow.
         
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

private extension KeyboardButton.Shadow {

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
