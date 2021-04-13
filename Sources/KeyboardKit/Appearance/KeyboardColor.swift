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
 */
public enum KeyboardColor: String, CaseIterable, Identifiable {
    
    case standardButton
    case standardButtonShadow
    case standardButtonTint
    case standardDarkAppearanceButton
    case standardDarkAppearanceButtonTint
    case standardDarkAppearanceDarkButton
    case standardDarkButton
    
    public static var bundle: Bundle = .module
    
    public var color: Color {
        Color(resourceName, bundle: Self.bundle)
    }
    
    public var id: String { rawValue }
    
    public var resourceName: String { rawValue }
}

struct KeyboardColor_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(KeyboardColor.allCases) { color in
                HStack {
                    color.color
                    color.color.colorScheme(.dark)
                }.frame(height: 100)
            }
        }.previewLayout(.sizeThatFits)
    }
}
