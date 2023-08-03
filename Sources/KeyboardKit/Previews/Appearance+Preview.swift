//
//  Appearance+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAppearance where Self == PreviewKeyboardAppearance {
    
    /**
     This preview appearance can be used in SwiftUI previews.
     */
    static var preview: KeyboardAppearance { PreviewKeyboardAppearance() }
}


extension KeyboardAppearance where Self == PreviewKeyboardAppearance {
    
    /**
     This preview appearance can be used in SwiftUI previews.
     */
    static var crazy: KeyboardAppearance { CrazyPreviewKeyboardAppearance() }
}


/**
 This appearance can be used in SwiftUI previews.
 */
public class PreviewKeyboardAppearance: StandardKeyboardAppearance {
    
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
 This internal appearance can be used in SwiftUI previews.
 */
class CrazyPreviewKeyboardAppearance: PreviewKeyboardAppearance {
    
    public override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        isPressed ? .preview2 : .preview1
    }
}
