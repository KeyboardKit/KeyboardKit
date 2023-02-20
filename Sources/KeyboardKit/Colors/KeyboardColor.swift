//
//  KeyboardColor.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-13.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defines raw, keyboard-specific asset-based colors.

 Although you can use this type directly, you should instead
 use the ``KeyboardColorReader`` protocol, to get extensions
 that build on these colors. `Color` already implements this
 protocol, so you can use it directly.
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
}

public extension KeyboardColor {

    /**
     The bundle to use to retrieve bundle-based color assets.

     You should only override this value when the entire set
     of colors should be loaded from another bundle.
     */
    static var bundle: Bundle = .keyboardKit
}

public extension KeyboardColor {
    
    /**
     The color's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     The color value.
     */
    var color: Color {
        Color(resourceName, bundle: Self.bundle)
    }

    /**
     The color asset name in the bundle asset catalog.
     */
    var resourceName: String { rawValue }
}

struct KeyboardColor_Previews: PreviewProvider {
    
    static func preview(for color: KeyboardColor) -> some View {
        VStack(alignment: .leading) {
            Text(color.resourceName).font(.footnote)
            HStack(spacing: 0) {
                color.color
                color.color.colorScheme(.dark)
            }
            .frame(height: 100)
            .cornerRadius(10)
        }
    }
    
    static var previews: some View {
        ScrollView {
            VStack {
                ForEach(KeyboardColor.allCases) {
                    preview(for: $0)
                }
            }.padding()
        }.background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}
