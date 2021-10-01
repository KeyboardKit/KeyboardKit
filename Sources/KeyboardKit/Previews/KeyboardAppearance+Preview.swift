//
//  KeyboardAppearance+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardAppearance where Self == PreviewKeyboardAppearance {
    
    /**
     This appearance can be used in SwiftUI previews.
     */
    static var preview: KeyboardAppearance { PreviewKeyboardAppearance() }
}

/**
 This action handler can be used in SwiftUI previews.
 */
public class PreviewKeyboardAppearance: KeyboardAppearance {
    
    init() {
        appearance = StandardKeyboardAppearance(context: .preview)
    }
    
    private let appearance: KeyboardAppearance
    
    public func buttonImage(for action: KeyboardAction) -> Image? {
        appearance.buttonImage(for: action)
    }
    
    public func buttonText(for action: KeyboardAction) -> String? {
        appearance.buttonText(for: action)
    }
    
    public func systemKeyboardButtonStyle(for action: KeyboardAction, isPressed: Bool) -> SystemKeyboardButtonStyle {
        appearance.systemKeyboardButtonStyle(for: action, isPressed: isPressed)
    }
}
