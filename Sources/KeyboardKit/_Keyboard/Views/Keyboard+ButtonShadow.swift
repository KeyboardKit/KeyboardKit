//
//  Keyboard+Shadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view mimics a native keyboard button shadow.
    ///
    /// Instead of being a shadow, the view is an overlay to
    /// support opaque shadows with semi-transparent buttons.
    ///
    /// You can style this component with the style modifier
    /// ``keyboardButtonStyle(_:)``. 
    struct ButtonShadow: View {
        
        /// Create a keyboard button shadow.
        public init() {}
        
        @Environment(\.keyboardButtonStyle)
        private var style

        public var body: some View {
            buttonShape
                .foregroundColor(shadowColor)
                .offset(y: shadowSize)
                .mask(buttonMask)
        }
    }
}

private extension Keyboard.ButtonShadow {

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

#Preview {
    
    VStack {
        Keyboard.ButtonShadow()
            .keyboardButtonStyle(.preview1)
        Keyboard.ButtonShadow()
            .keyboardButtonStyle(.preview2)
    }
    .padding()
}
