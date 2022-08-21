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
 to easily change the overall appearance of a keyboard.
 */
public extension Color {
    
    /**
     The standard background color of light keyboard buttons.
     */
    static var standardButtonBackground = color(
        for: .standardButtonBackground)
    
    /**
     The standard background color of light keyboard buttons
     when accounting for the iOS dark mode bug.
     */
    static var standardButtonBackgroundForColorSchemeBug = color(
        for: .standardButtonBackgroundForColorSchemeBug)
    
    /**
     The standard background color of light keyboard buttons
     in dark keyboard appearance.
     */
    static var standardButtonBackgroundForDarkAppearance = color(
        for: .standardButtonBackgroundForDarkAppearance)
    
    /**
     The standard foreground color of light keyboard buttons.
     */
    static var standardButtonForeground = color(
        for: .standardButtonForeground)
    
    /**
     The standard foreground color of light keyboard buttons
     in dark keyboard appearance.
     */
    static var standardButtonForegroundForDarkAppearance = color(
        for: .standardButtonForegroundForDarkAppearance)
    
    /**
     The standard shadow color of keyboard buttons.
     */
    static var standardButtonShadow = color(
        for: .standardButtonShadow)
    
    /**
     The standard background color of a dark keyboard button.
     */
    static var standardDarkButtonBackground = color(
        for: .standardDarkButtonBackground)
    
    /**
     The standard background color of a dark keyboard button
     when accounting for the iOS dark mode bug.
     */
    static var standardDarkButtonBackgroundForColorSchemeBug = color(
        for: .standardDarkButtonBackgroundForColorSchemeBug)
    
    /**
     The standard background color of a dark keyboard button
     in dark keyboard appearance.
     */
    static var standardDarkButtonBackgroundForDarkAppearance = color(
        for: .standardDarkButtonBackgroundForDarkAppearance)
    
    /**
     The standard foreground color of a dark keyboard button.
     */
    static var standardDarkButtonForeground = color(
        for: .standardButtonForeground)
    
    /**
     The standard foreground color of a dark keyboard button
     in dark keyboard appearance.
     */
    static var standardDarkButtonForegroundForDarkAppearance = color(
        for: .standardButtonForegroundForDarkAppearance)
    
    /**
     The standard keyboard background color.
     */
    static var standardKeyboardBackground = color(
        for: .standardKeyboardBackground)
    
    /**
     The standard keyboard background color in dark keyboard
     appearance.
     */
    static var standardKeyboardBackgroundForDarkAppearance = color(
        for: .standardKeyboardBackgroundForDarkAppearance)
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
            HStack(spacing: 0) {
                color
                color.colorScheme(.dark)
            }
            .frame(height: 100)
            .cornerRadius(10)
        }
    }
    
    static var previews: some View {
        ScrollView {
            VStack {
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
            }.padding()
        }.background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}
