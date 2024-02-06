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

 Instead of using this type directly, you should instead use
 the keyboard-specific `Color` extensions.
 */
enum KeyboardColor: String, CaseIterable, Identifiable {
    
    /// The standard keyboard background color.
    case keyboardBackground
    
    /// The standard keyboard background color for dark appearance.
    case keyboardBackgroundForDarkAppearance
    
    /// The standard keyboard button background color.
    case keyboardButtonBackground
    
    /// A keyboard button background color that fixes a color scheme bug.
    case keyboardButtonBackgroundForColorSchemeBug
    
    /// The standard keyboard button background color for dark appearance.
    case keyboardButtonBackgroundForDarkAppearance
    
    /// The standard keyboard button foreground color.
    case keyboardButtonForeground
    
    /// The standard keyboard button foreground color for dark appearance.
    case keyboardButtonForegroundForDarkAppearance
    
    /// The standard keyboard button shadow color.
    case keyboardButtonShadow
    
    /// The standard dark keyboard button background color.
    case keyboardDarkButtonBackground
    
    /// A dark keyboard button background color that fixes a color scheme bug.
    case keyboardDarkButtonBackgroundForColorSchemeBug
    
    /// The standard dark keyboard button background color for dark apperance.
    case keyboardDarkButtonBackgroundForDarkAppearance
}

extension KeyboardColor {

    /**
     The bundle to use to retrieve bundle-based color assets.

     You should only override this value when the entire set
     of colors should be loaded from another bundle.
     */
    static var bundle: Bundle = .keyboardKit
}

extension KeyboardColor {
    
    /// The color's unique identifier.
    var id: String { rawValue }
    
    /// The color value.
    var color: Color {
        Color(resourceName, bundle: Self.bundle)
    }

    /// The color asset name in the bundle asset catalog.
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
