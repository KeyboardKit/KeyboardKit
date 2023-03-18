//
//  KeyboardAppearance+Preview.swift
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
    
    public override var inputCalloutStyle: KeyboardInputCalloutStyle {
        .init(
            callout: .preview1,
            calloutSize: CGSize(width: 0, height: 40),
            font: .body
        )
    }
    
    public override var actionCalloutStyle: KeyboardActionCalloutStyle {
        .init(
            callout: .preview1,
            font: .headline,
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
    
    public override func buttonStyle(for action: KeyboardAction, isPressed: Bool) -> KeyboardButtonStyle {
        isPressed ? .preview2 : .preview1
    }
}
