//
//  Appearance+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardStyleProvider where Self == PreviewKeyboardStyleProvider {
    
    /**
     This style provider can be used in SwiftUI previews.
     */
    static var preview: KeyboardStyleProvider { PreviewKeyboardStyleProvider() }
}


extension KeyboardStyleProvider where Self == PreviewKeyboardStyleProvider {
    
    /**
     This style provider can be used in SwiftUI previews.
     */
    static var crazy: KeyboardStyleProvider { CrazyPreviewKeyboardStyleProvider() }
}


/**
 This style provider can be used in SwiftUI previews.
 */
public class PreviewKeyboardStyleProvider: StandardKeyboardStyleProvider {
    
    init() {
        super.init(keyboardContext: .preview)
    }
    
    public override var inputCalloutStyle: KeyboardStyle.InputCallout {
        .init(
            callout: .preview1,
            calloutSize: CGSize(width: 0, height: 40),
            font: .init(.body, .regular)
        )
    }
    
    public override var actionCalloutStyle: KeyboardStyle.ActionCallout {
        .init(
            callout: .preview1,
            font: .init(.headline),
            selectedBackgroundColor: .yellow,
            selectedForegroundColor: .black,
            verticalTextPadding: 10
        )
    }
}

/**
 This style provider can be used in SwiftUI previews.
 */
class CrazyPreviewKeyboardStyleProvider: PreviewKeyboardStyleProvider {
    
    public override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        isPressed ? .preview2 : .preview1
    }
}
