//
//  Color+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-20.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    /**
     This color can be used instead of `.clear` if the color
     should be registering touches and gestures.

     This will be phased out. Instead of this, use a content
     shape within buttons and views that use touches.
     */
    static var clearInteractable: Color {
        Color.white.opacity(0.001)
    }
    
    /// The standard keyboard background color.
    static var keyboardBackground: Color {
        color(for: .keyboardBackground)
    }
    
    /// The standard keyboard background color for dark appearance.
    static var keyboardBackgroundForDarkAppearance: Color {
        color(for: .keyboardBackgroundForDarkAppearance)
    }
    
    /// The standard keyboard button background color.
    static var keyboardButtonBackground: Color {
        color(for: .keyboardButtonBackground)
    }
    
    /// The standard keyboard button background color for dark appearance.
    static var keyboardButtonBackgroundForDarkAppearance: Color {
        color(for: .keyboardButtonBackgroundForDarkAppearance)
    }
    
    /// The standard keyboard button foreground color.
    static var keyboardButtonForeground: Color {
        color(for: .keyboardButtonForeground)
    }
    
    /// The standard keyboard button foreground color for dark appearance.
    static var keyboardButtonForegroundForDarkAppearance: Color {
        color(for: .keyboardButtonForegroundForDarkAppearance)
    }
    
    /// The standard keyboard button shadow color.
    static var keyboardButtonShadow: Color {
        color(for: .keyboardButtonShadow)
    }
    
    /// The standard dark keyboard button background color.
    static var keyboardDarkButtonBackground: Color {
        color(for: .keyboardDarkButtonBackground)
    }
    
    /// The standard dark keyboard button background color for dark apperance.
    static var keyboardDarkButtonBackgroundForDarkAppearance: Color {
        color(for: .keyboardDarkButtonBackgroundForDarkAppearance)
    }
    
    /// The standard dark keyboard button foreground color.
    static var keyboardDarkButtonForeground: Color {
        color(for: .keyboardButtonForeground)
    }
    
    /// The standard dark keyboard button foreground color for dark apperance.
    static var keyboardDarkButtonForegroundForDarkAppearance: Color {
        color(for: .keyboardButtonForegroundForDarkAppearance)
    }
}

// MARK: - Contextual Colors

public extension Color {
    
    /// The standard keyboard button background color.
    static func keyboardBackground(for context: KeyboardContext) -> Color {
        .keyboardBackground
    }
    
    /// The standard keyboard button background color.
    static func keyboardButtonBackground(for context: KeyboardContext) -> Color {
        context.hasDarkColorScheme ?
            .keyboardButtonBackgroundForColorSchemeBug :
            .keyboardButtonBackground
    }

    /// The standard keyboard button foreground color.
    static func keyboardButtonForeground(for context: KeyboardContext) -> Color {
        context.hasDarkColorScheme ?
            .keyboardButtonForegroundForDarkAppearance :
            .keyboardButtonForeground
    }

    /// The standard keyboard button shadow color.
    static func keyboardButtonShadow(for context: KeyboardContext) -> Color {
        .keyboardButtonShadow
    }

    /// The standard dark keyboard button background color.
    static func keyboardDarkButtonBackground(for context: KeyboardContext) -> Color {
        context.hasDarkColorScheme ?
            .keyboardDarkButtonBackgroundForColorSchemeBug :
            .keyboardDarkButtonBackground
    }

    /// The standard dark keyboard button foreground color.
    static func keyboardDarkButtonForeground(for context: KeyboardContext) -> Color {
        context.hasDarkColorScheme ?
            .keyboardDarkButtonForegroundForDarkAppearance :
            .keyboardDarkButtonForeground
    }
}


// MARK: - Internal Functions

extension Color {
    
    static var keyboardButtonBackgroundForColorSchemeBug: Color {
        color(for: .keyboardButtonBackgroundForColorSchemeBug)
    }
    
    static var keyboardDarkButtonBackgroundForColorSchemeBug: Color {
        color(for: .keyboardDarkButtonBackgroundForColorSchemeBug)
    }
}


// MARK: - Private Functions

private extension Color {
    
    static func color(for color: KeyboardColor) -> Color {
        color.color
    }
}

struct Color_KeyboardKit_Previews: PreviewProvider {
    
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
                    preview(for: .keyboardBackground, name: "keyboardBackground")
                    preview(for: .keyboardBackgroundForDarkAppearance, name: "keyboardBackgroundForDarkAppearance")
                }
                Group {
                    preview(for: .keyboardButtonBackground, name: "keyboardButtonBackground")
                    preview(for: .keyboardButtonBackgroundForColorSchemeBug, name: "keyboardButtonBackgroundForColorSchemeBug")
                    preview(for: .keyboardButtonBackgroundForDarkAppearance, name: "keyboardButtonBackgroundForDarkAppearance")
                    preview(for: .keyboardButtonForeground, name: "keyboardButtonForeground")
                    preview(for: .keyboardButtonForegroundForDarkAppearance, name: "keyboardButtonForegroundForDarkAppearance")
                    preview(for: .keyboardButtonShadow, name: "keyboardButtonShadow")
                }
                Group {
                    preview(for: .keyboardDarkButtonBackground, name: "keyboardDarkButtonBackground")
                    preview(for: .keyboardDarkButtonBackgroundForColorSchemeBug, name: "keyboardDarkButtonBackgroundForColorSchemeBug")
                    preview(for: .keyboardDarkButtonBackgroundForDarkAppearance, name: "keyboardDarkButtonBackgroundForDarkAppearance")
                    preview(for: .keyboardDarkButtonForeground, name: "keyboardDarkButtonForeground")
                    preview(for: .keyboardDarkButtonForegroundForDarkAppearance, name: "keyboardDarkButtonForegroundForDarkAppearance")
                }
            }.padding()
        }.background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}
