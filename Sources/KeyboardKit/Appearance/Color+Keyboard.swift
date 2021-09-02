//
//  Color+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 These lazy `Color` extensions can be overridden if you want
 to change the overall appearance of a keyboard extension in
 the easiest way possible.
 */
public extension Color {
    
    static var standardButtonBackground: Color = color(for: .standardButtonBackground)
    static var standardButtonBackgroundForColorSchemeBug: Color = color(for: .standardDarkButtonBackgroundForColorSchemeBug)
    static var standardButtonBackgroundForDarkAppearance: Color = color(for: .standardButtonBackgroundForDarkAppearance)
    static var standardButtonForeground: Color = color(for: .standardButtonForeground)
    static var standardButtonForegroundForDarkAppearance: Color = color(for: .standardButtonForegroundForDarkAppearance)
    static var standardButtonShadow: Color = color(for: .standardButtonShadow)
    static var standardDarkButtonBackground: Color = color(for: .standardDarkButtonBackground)
    static var standardDarkButtonBackgroundForColorSchemeBug: Color = color(for: .standardDarkButtonBackgroundForColorSchemeBug)
    static var standardDarkButtonBackgroundForDarkAppearance: Color = color(for: .standardDarkButtonBackgroundForDarkAppearance)
    static var standardDarkButtonForeground: Color = color(for: .standardButtonForeground)
    static var standardDarkButtonForegroundForDarkAppearance: Color = color(for: .standardButtonForegroundForDarkAppearance)
    static var standardKeyboardBackground: Color = color(for: .standardKeyboardBackground)
    static var standardKeyboardBackgroundForDarkAppearance: Color = color(for: .standardKeyboardBackgroundForDarkAppearance)
}

private extension Color {
    
    static func color(for color: KeyboardColor) -> Color {
        color.color
    }
}

struct Color_Keyboard_Previews: PreviewProvider {
    
    static func preview(for color: Color, name: String) -> some View {
        VStack(alignment: .leading) {
            Text(name).font(.footnote)
            HStack {
                color
                color.colorScheme(.dark)
            }.frame(height: 100)
        }
    }
    
    static var previews: some View {
        Group {
            Group {
                preview(for: .standardButtonBackground, name: "standardButtonBackground")
                preview(for: .standardButtonBackgroundForColorSchemeBug, name: "standardButtonBackgroundForColorSchemeBug")
                preview(for: .standardButtonBackgroundForDarkAppearance, name: "standardButtonBackgroundForDarkAppearance")
                preview(for: .standardButtonForeground, name: "standardButtonForeground")
                preview(for: .standardButtonForegroundForDarkAppearance, name: "standardButtonForegroundForDarkAppearance")
                preview(for: .standardButtonShadow, name: "standardButtonShadow")
            }
            Group {
                preview(for: .standardDarkButtonBackground, name: "standardDarkButtonBackground")
                preview(for: .standardDarkButtonBackgroundForColorSchemeBug, name: "standardDarkButtonBackgroundForColorSchemeBug")
                preview(for: .standardDarkButtonBackgroundForDarkAppearance, name: "standardDarkButtonBackgroundForDarkAppearance")
                preview(for: .standardDarkButtonForeground, name: "standardDarkButtonForeground")
                preview(for: .standardDarkButtonForegroundForDarkAppearance, name: "standardDarkButtonForegroundForDarkAppearance")
                preview(for: .standardKeyboardBackground, name: "standardKeyboardBackground")
                preview(for: .standardKeyboardBackgroundForDarkAppearance, name: "standardKeyboardBackgroundForDarkAppearance")
            }
        }.previewLayout(.sizeThatFits)
    }
}
