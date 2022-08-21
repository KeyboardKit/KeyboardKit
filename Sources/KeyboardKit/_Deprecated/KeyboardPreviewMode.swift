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
 You can also provide custom values. Read more about this in
 the `KeyboardColor` documentation.
 */
@available(*, deprecated, message: "Preview mode is no longer needed and enabling it has no effect.")
public final class KeyboardPreviewMode {
    
    public typealias ColorProvider = (KeyboardColor) -> Color
        
    /**
     The color provider to use when `usePreviewColorProvider`
     is true and a color is resolved in a SwiftUI preview.
     */
    public static let colorProvider: ColorProvider = {
        switch $0 {
        case .standardButtonBackground: return .white
        case .standardButtonBackgroundForColorSchemeBug: return .gray
        case .standardButtonBackgroundForDarkAppearance: return .gray
        case .standardButtonForeground: return .black
        case .standardButtonForegroundForDarkAppearance: return .white
        case .standardButtonShadow: return .black
        case .standardDarkButtonBackground: return .gray
        case .standardDarkButtonBackgroundForColorSchemeBug: return .white
        case .standardDarkButtonBackgroundForDarkAppearance: return .white
        case .standardKeyboardBackground: return .gray
        case .standardKeyboardBackgroundForDarkAppearance: return .white
        }
    }
    
    public static func enable(
        colorProvider: ColorProvider? = colorProvider) {
    }
}
