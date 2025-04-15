import SwiftUI

@available(*, deprecated, message: "Use colorScheme variant instead.")
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
