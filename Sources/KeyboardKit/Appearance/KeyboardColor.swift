//
//  KeyboardColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum contains keyboard-specific, resource-based colors.
 
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
    
    case standardButtonBackground
    case standardButtonBackgroundForColorSchemeBug
    case standardButtonBackgroundForDarkAppearance
    case standardButtonForeground
    case standardButtonForegroundForDarkAppearance
    case standardButtonShadow
    case standardDarkButtonBackground
    case standardDarkButtonBackgroundForColorSchemeBug
    case standardDarkButtonBackgroundForDarkAppearance
    case standardKeyboardBackground
    case standardKeyboardBackgroundForDarkAppearance
    
    /**
     Whether or not to use the `previewColorProvider` when a
     color is presented in a preview.
     */
    static var usePreviewColorProvider = false
    
    /**
     The color provider to use when `usePreviewColorProvider`
     is true and a color is resolved in a SwiftUI preview.
     */
    static var previewColorProvider: (KeyboardColor) -> Color = { _ in .clear }
}

public extension KeyboardColor {
    
    /**
     The color's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     This color property is adaptive, since the bundle isn't
     available when previewing these colors from another app
     or library project except this library.
     */
    var color: Color {
        if isSwiftUIPreview && Self.usePreviewColorProvider {
            return Self.previewColorProvider(self)
        } else {
            return Color(resourceName, bundle: .module)
        }
    }
    
    var resourceName: String { rawValue }
}

private extension KeyboardColor {
    
    var isSwiftUIPreview: Bool {
        ProcessInfo.processInfo.isSwiftUIPreview
    }
}

struct KeyboardColor_Previews: PreviewProvider {
    
    static func preview(for color: KeyboardColor) -> some View {
        VStack(alignment: .leading) {
            Text(color.resourceName).font(.footnote)
            HStack {
                color.color
                color.color.colorScheme(.dark)
            }.frame(height: 100)
        }
    }
    
    static var previews: some View {
        return Group {
            ForEach(KeyboardColor.allCases) {
                preview(for: $0)
            }
        }.previewLayout(.sizeThatFits)
    }
}
