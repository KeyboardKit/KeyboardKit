//
//  KeyboardPreviews+Styling.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyleProvider where Self == KeyboardPreviews.PreviewKeyboardStyleProvider {
    
    static var preview: KeyboardStyleProvider {
        KeyboardPreviews.PreviewKeyboardStyleProvider()
    }
}

extension KeyboardStyleProvider where Self == KeyboardPreviews.CrazyStyleProvider {
    
    static var crazy: KeyboardStyleProvider {
        KeyboardPreviews.CrazyStyleProvider()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardStyleProvider: StandardKeyboardStyleProvider {
        
        init() {
            super.init(keyboardContext: .preview)
        }
    }
}

extension KeyboardPreviews {

    /// This style provider can be used in SwiftUI KeyboardPreviews.
    class CrazyStyleProvider: KeyboardPreviews.PreviewKeyboardStyleProvider {
        
        override func buttonStyle(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> KeyboardButton.ButtonStyle {
            isPressed ? .preview2 : .preview1
        }
        
        override var inputCalloutStyle: KeyboardStyle.InputCallout {
            .init(
                callout: .preview1,
                calloutSize: CGSize(width: 0, height: 40),
                font: .init(.body, .regular)
            )
        }
        
        override var actionCalloutStyle: KeyboardStyle.ActionCallout {
            .init(
                callout: .preview1,
                font: .init(.headline),
                selectedBackgroundColor: .yellow,
                selectedForegroundColor: .black,
                verticalTextPadding: 10
            )
        }
    }
}
