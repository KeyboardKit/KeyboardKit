//
//  KeyboardPreviews+Styling.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyleService where Self == KeyboardPreviews.PreviewKeyboardStyleService {

    static var preview: KeyboardStyleService {
        KeyboardPreviews.PreviewKeyboardStyleService()
    }
}

extension KeyboardStyleService where Self == KeyboardPreviews.CrazyStyleService {

    static var crazy: KeyboardStyleService {
        KeyboardPreviews.CrazyStyleService()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardStyleService: KeyboardStyle.StandardService {

        init() {
            super.init(keyboardContext: .preview)
        }
    }
}

extension KeyboardPreviews {

    /// This style provider can be used in SwiftUI KeyboardPreviews.
    class CrazyStyleService: KeyboardPreviews.PreviewKeyboardStyleService {

        override func buttonStyle(
            for action: KeyboardAction,
            isPressed: Bool
        ) -> Keyboard.ButtonStyle {
            isPressed ? .preview2 : .preview1
        }
        
        override var inputCalloutStyle: Callouts.InputCalloutStyle {
            .init(
                callout: .preview1,
                calloutSize: CGSize(width: 0, height: 40),
                font: .init(.body, .regular)
            )
        }
        
        override var actionCalloutStyle: Callouts.ActionCalloutStyle {
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
