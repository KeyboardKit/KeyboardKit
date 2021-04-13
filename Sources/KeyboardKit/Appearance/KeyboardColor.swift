//
//  KeyboardColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum contains keyboard-specific colors.
 
 Colors are embedded as resources in the KeyboardKit package
 and use the SPM generated `.module` bundle by default. When
 not using SPM, `.module` will be undefined and this linking
 will fail. CocoaPods solves this by adding a `Bundle+module`
 file that is ignored by SPM.
 
 Another problem with this is that SwiftUI previews will not
 work outside of this package, but crash since the module is
 not found. If your previews keeps crashing due to this, you
 can set the `usePreviewColorProvider` property to true. You
 can also replace the `previewColorProvider` property with a
 custom provider. Note that the preview colors are incorrect
 and do not support dark mode.
 */
public enum KeyboardColor: String, CaseIterable, Identifiable {
    
    case standardButton
    case standardButtonShadow
    case standardButtonTint
    case standardDarkAppearanceButton
    case standardDarkAppearanceButtonTint
    case standardDarkAppearanceDarkButton
    case standardDarkButton
    
    /**
     Whether or not to use the `previewColorProvider` when a
     color is presented in a preview.
     */
    public static var usePreviewColorProvider = false
    
    /**
     The color provider to use when `usePreviewColorProvider`
     is true and a color is resolved in a SwiftUI preview.
     */
    public static var previewColorProvider: (KeyboardColor) -> Color = {
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
}

public extension KeyboardColor {
    
    var id: String { rawValue }
    
    var color: Color {
        if ProcessInfo.processInfo.isSwiftUIPreview && Self.usePreviewColorProvider {
            return Self.previewColorProvider(self)
        } else {
            return Color(resourceName, bundle: .module)
        }
    }
    
    var resourceName: String { rawValue }
}

struct KeyboardColor_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            ForEach(KeyboardColor.allCases) { color in
                HStack {
                    color.color
                    color.color.colorScheme(.dark)
                }.frame(height: 100)
            }
        }.previewLayout(.sizeThatFits)
    }
}
