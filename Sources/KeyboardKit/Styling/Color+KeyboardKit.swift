//
//  Color+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-20.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    /// This color can be used instead of `clear` to make it
    /// register touches & gestures.
    static var clearInteractable: Self {
        Color.white.opacity(0.001)
    }
    
    /// The standard keyboard background color.
    static var keyboardBackground: Self {
        color(for: .keyboardBackground)
    }
    
    /// The standard keyboard background color for dark appearance.
    static var keyboardBackgroundForDarkAppearance: Self {
        color(for: .keyboardBackgroundForDarkAppearance)
    }
    
    /// The standard keyboard button background color.
    static var keyboardButtonBackground: Self {
        color(for: .keyboardButtonBackground)
    }
    
    /// The standard keyboard button background color for dark appearance.
    static var keyboardButtonBackgroundForDarkAppearance: Self {
        color(for: .keyboardButtonBackgroundForDarkAppearance)
    }
    
    /// The standard keyboard button foreground color.
    static var keyboardButtonForeground: Self {
        color(for: .keyboardButtonForeground)
    }
    
    /// The standard keyboard button foreground color for dark appearance.
    static var keyboardButtonForegroundForDarkAppearance: Self {
        color(for: .keyboardButtonForegroundForDarkAppearance)
    }
    
    /// The standard keyboard button shadow color.
    static var keyboardButtonShadow: Self {
        color(for: .keyboardButtonShadow)
    }
    
    /// The standard dark keyboard button background color.
    static var keyboardDarkButtonBackground: Self {
        color(for: .keyboardDarkButtonBackground)
    }
    
    /// The standard dark keyboard button background color for dark apperance.
    static var keyboardDarkButtonBackgroundForDarkAppearance: Self {
        color(for: .keyboardDarkButtonBackgroundForDarkAppearance)
    }
    
    /// The standard dark keyboard button foreground color.
    static var keyboardDarkButtonForeground: Self {
        color(for: .keyboardButtonForeground)
    }
    
    /// The standard dark keyboard button foreground color for dark apperance.
    static var keyboardDarkButtonForegroundForDarkAppearance: Self {
        color(for: .keyboardButtonForegroundForDarkAppearance)
    }
}

// MARK: - Contextual Colors

public extension Color {
    
    /// The standard keyboard button background color.
    static func keyboardBackground(for context: KeyboardContext) -> Self {
        .keyboardBackground
    }
    
    /// The standard keyboard button background color.
    static func keyboardButtonBackground(for context: KeyboardContext) -> Self {
        context.hasDarkColorScheme ?
            .keyboardButtonBackgroundForColorSchemeBug :
            .keyboardButtonBackground
    }

    /// The standard keyboard button foreground color.
    static func keyboardButtonForeground(for context: KeyboardContext) -> Self {
        context.hasDarkColorScheme ?
            .keyboardButtonForegroundForDarkAppearance :
            .keyboardButtonForeground
    }

    /// The standard keyboard button shadow color.
    static func keyboardButtonShadow(for context: KeyboardContext) -> Self {
        .keyboardButtonShadow
    }

    /// The standard dark keyboard button background color.
    static func keyboardDarkButtonBackground(for context: KeyboardContext) -> Self {
        context.hasDarkColorScheme ?
            .keyboardDarkButtonBackgroundForColorSchemeBug :
            .keyboardDarkButtonBackground
    }

    /// The standard dark keyboard button foreground color.
    static func keyboardDarkButtonForeground(for context: KeyboardContext) -> Self {
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
    
    static func color(
        for color: KeyboardColor
    ) -> Color {
        Color(color.resourceName, bundle: .keyboardKit)
    }
}

#Preview {

    return ScrollView(.vertical) {
        VStack(spacing: 40) {
            StylePreviewHeader(title: "KeyboardKit Colors")

            LazyVGrid(columns: .preview, spacing: 20) {
                preview(for: .keyboardBackground, "keyboardBackground")
                preview(for: .keyboardBackgroundForDarkAppearance, "keyboardBackgroundForDarkAppearance")
                preview(for: .keyboardButtonBackground, "keyboardButtonBackground")
                preview(for: .keyboardButtonBackgroundForColorSchemeBug, "keyboardButtonBackgroundForColorSchemeBug")
                preview(for: .keyboardButtonBackgroundForDarkAppearance, "keyboardButtonBackgroundForDarkAppearance")
                preview(for: .keyboardButtonForeground, "keyboardButtonForeground")
                preview(for: .keyboardButtonForegroundForDarkAppearance, "keyboardButtonForegroundForDarkAppearance")
                preview(for: .keyboardButtonShadow, "keyboardButtonShadow")
                preview(for: .keyboardDarkButtonBackground, "keyboardDarkButtonBackground")
                preview(for: .keyboardDarkButtonBackgroundForColorSchemeBug, "keyboardDarkButtonBackgroundForColorSchemeBug")
                preview(for: .keyboardDarkButtonBackgroundForDarkAppearance, "keyboardDarkButtonBackgroundForDarkAppearance")
                preview(for: .keyboardDarkButtonForeground, "keyboardDarkButtonForeground")
                preview(for: .keyboardDarkButtonForegroundForDarkAppearance, "keyboardDarkButtonForegroundForDarkAppearance")
            }
        }
        .padding()
        .font(.title.weight(.regular))
    }

    func preview(for color: Color, _ name: String) -> some View {
        Button {
            print(name)
        } label: {
            HStack(spacing: 0) {
                color
                color.colorScheme(.dark)
            }
        }
        .background(Color.keyboardBackground)
        .aspectRatio(1, contentMode: .fill)
        .cornerRadius(10)
        .shadow(radius: 1, y: 1)
    }
}

struct StylePreviewHeader: View {

    let title: String

    var body: some View {
        VStack {
            Image.keyboardKit
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            Text(title)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.keyboardBackground)
        .clipShape(.rect(cornerRadius: 5))
        .shadow(radius: 1, y: 1)
    }
}

private extension Array where Element == GridItem {

    static var preview: Self {
        [.init(.adaptive(minimum: 100, maximum: 120), spacing: 20)]
    }
}
