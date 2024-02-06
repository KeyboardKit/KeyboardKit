import SwiftUI

public extension Color {
    
    @available(*, deprecated, renamed: "keyboardBackground")
    static var standardKeyboardBackground: Color {
        keyboardBackground
    }
    
    @available(*, deprecated, renamed: "keyboardBackgroundForDarkAppearance")
    static var standardKeyboardBackgroundForDarkAppearance: Color {
        keyboardBackgroundForDarkAppearance
    }
    
    @available(*, deprecated, renamed: "keyboardButtonBackground")
    static var standardButtonBackground: Color {
        keyboardButtonBackground
    }
    
    @available(*, deprecated, renamed: "keyboardButtonBackgroundForDarkAppearance")
    static var standardButtonBackgroundForDarkAppearance: Color {
        keyboardButtonBackgroundForDarkAppearance
    }
    
    @available(*, deprecated, renamed: "keyboardButtonForeground")
    static var standardButtonForeground: Color {
        keyboardButtonForeground
    }
    
    @available(*, deprecated, renamed: "keyboardButtonForegroundForDarkAppearance")
    static var standardButtonForegroundForDarkAppearance: Color {
        keyboardButtonForegroundForDarkAppearance
    }
    
    @available(*, deprecated, renamed: "keyboardButtonShadow")
    static var standardButtonShadow: Color {
        keyboardButtonShadow
    }
    
    @available(*, deprecated, renamed: "keyboardDarkButtonBackground")
    static var standardDarkButtonBackground: Color {
        keyboardDarkButtonBackground
    }
    
    @available(*, deprecated, renamed: "keyboardDarkButtonBackgroundForDarkAppearance")
    static var standardDarkButtonBackgroundForDarkAppearance: Color {
        keyboardDarkButtonBackgroundForDarkAppearance
    }
    
    @available(*, deprecated, renamed: "keyboardDarkButtonForeground")
    static var standardDarkButtonForeground: Color {
        keyboardDarkButtonForeground
    }
    
    @available(*, deprecated, renamed: "keyboardDarkButtonForegroundForDarkAppearance")
    static var standardDarkButtonForegroundForDarkAppearance: Color {
        keyboardDarkButtonForegroundForDarkAppearance
    }
}

public extension Color {
    
    @available(*, deprecated, renamed: "keyboardKeyboardBackground(for:)")
    static func standardKeyboardBackground(for context: KeyboardContext) -> Color {
        keyboardBackground(for: context)
    }
    
    @available(*, deprecated, renamed: "keyboardButtonBackground(for:)")
    static func standardButtonBackground(for context: KeyboardContext) -> Color {
        keyboardButtonBackground(for: context)
    }

    @available(*, deprecated, renamed: "keyboardButtonForeground(for:)")
    static func standardButtonForeground(for context: KeyboardContext) -> Color {
        keyboardButtonForeground(for: context)
    }

    @available(*, deprecated, renamed: "keyboardButtonShadow(for:)")
    static func standardButtonShadow(for context: KeyboardContext) -> Color {
        keyboardButtonShadow(for: context)
    }

    @available(*, deprecated, renamed: "keyboardDarkButtonBackground(for:)")
    static func standardDarkButtonBackground(for context: KeyboardContext) -> Color {
        keyboardDarkButtonBackground(for: context)
    }

    @available(*, deprecated, renamed: "keyboardDarkButtonForeground(for:)")
    static func standardDarkButtonForeground(for context: KeyboardContext) -> Color {
        keyboardDarkButtonForeground(for: context)
    }
}

extension KeyboardColor {
    
    @available(*, deprecated, renamed: "keyboardBackground")
    static let standardKeyboardBackground = Self.keyboardBackground
    
    @available(*, deprecated, renamed: "keyboardBackgroundForDarkAppearance")
    static let standardKeyboardBackgroundForDarkAppearance = Self.keyboardBackgroundForDarkAppearance
    
    @available(*, deprecated, renamed: "keyboardButtonBackground")
    static let standardButtonBackground = Self.keyboardButtonBackground
    
    @available(*, deprecated, renamed: "keyboardButtonBackgroundForColorSchemeBug")
    static let standardButtonBackgroundForColorSchemeBug = Self.keyboardButtonBackgroundForColorSchemeBug
    
    @available(*, deprecated, renamed: "keyboardButtonBackgroundForDarkAppearance")
    static let standardButtonBackgroundForDarkAppearance = Self.keyboardButtonBackgroundForDarkAppearance
    
    @available(*, deprecated, renamed: "keyboardButtonForeground")
    static let standardButtonForeground = Self.keyboardButtonForeground
    
    @available(*, deprecated, renamed: "keyboardButtonForegroundForDarkAppearance")
    static let standardButtonForegroundForDarkAppearance = Self.keyboardButtonForegroundForDarkAppearance
    
    @available(*, deprecated, renamed: "keyboardButtonShadow")
    static let standardButtonShadow = Self.keyboardButtonShadow
    
    @available(*, deprecated, renamed: "keyboardDarkButtonBackground")
    static let standardDarkButtonBackground = Self.keyboardDarkButtonBackground
    
    @available(*, deprecated, renamed: "keyboardDarkButtonBackgroundForColorSchemeBug")
    static let standardDarkButtonBackgroundForColorSchemeBug = Self.keyboardDarkButtonBackgroundForColorSchemeBug
    
    @available(*, deprecated, renamed: "keyboardDarkButtonBackgroundForDarkAppearance")
    static let standardDarkButtonBackgroundForDarkAppearance = Self.keyboardDarkButtonBackgroundForDarkAppearance
}
