//
//  KeyboardButton+Shadow.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-09-02.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /// This view mimics a native keyboard button shadow.
    ///
    /// Instead of being a shadow, the view is an overlay to
    /// support opaque shadows with semi-transparent buttons.
    ///
    /// You can style this component using the view modifier
    /// ``keyboardButtonStyle(_:)``. 
    struct Shadow: View {
        
        /// Create a keyboard button shadow.
        public init() {
            self.initStyle = nil
        }
        
        @available(*, deprecated, message: "Style this view with .keyboardButtonStyle instead.")
        public init(style: KeyboardButton.ButtonStyle) {
            self.initStyle = style
        }
        
        @Environment(\.keyboardButtonStyle)
        private var envStyle
        
        public var body: some View {
            buttonShape
                .foregroundColor(shadowColor)
                .offset(y: shadowSize)
                .mask(buttonMask)
        }
        
        // MARK: - Deprecated
        
        private typealias Style = KeyboardButton.ButtonStyle
        private let initStyle: Style?
        private var style: Style { initStyle ?? envStyle }
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

#Preview {
    
    VStack {
        KeyboardButton.Shadow()
            .keyboardButtonStyle(.preview1)
        KeyboardButton.Shadow()
            .keyboardButtonStyle(.preview2)
    }
    .padding()
}
