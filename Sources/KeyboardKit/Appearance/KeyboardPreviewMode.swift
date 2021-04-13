//
//  KeyboardPreviewMode.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This is a hopefully temporary class that can be used to get
 SwiftUI previews to work outside of the KeyboardKit package.
 
 Call `KeyboardPreviewMode.enable()` in any crashing preview
 to bypass the undefined resources and make the preview work.
 You can also provide custom values.
 
 Read more about the problem in `KKL10n` and `KeyboardColor`.
 */
public final class KeyboardPreviewMode {
    
    public typealias ColorProvider = (KeyboardColor) -> Color
        
    /**
     The color provider to use when `usePreviewColorProvider`
     is true and a color is resolved in a SwiftUI preview.
     */
    public static let colorProvider: ColorProvider = {
        switch $0 {
        case .standardButton: return .white
        case .standardButtonShadow: return .black
        case .standardButtonTint: return .black
        case .standardDarkAppearanceButton: return .gray
        case .standardDarkAppearanceButtonTint: return .white
        case .standardDarkAppearanceDarkButton: return .gray
        case .standardDarkButton: return .gray
        }
    }
    
    public static func enable(
        colorProvider: ColorProvider? = colorProvider) {
        KKL10n.usePreviewTexts = true
        KeyboardColor.previewColorProvider = colorProvider ?? self.colorProvider
        KeyboardColor.usePreviewColorProvider = true
    }
}
