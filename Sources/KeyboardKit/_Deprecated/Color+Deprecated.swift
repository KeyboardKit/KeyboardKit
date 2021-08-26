import SwiftUI

public extension Color {
    
    @available(*, deprecated, renamed: "standardButtonBackground")
    static let standardButton = standardButtonBackground
    @available(*, deprecated, renamed: "standardButtonForeground")
    static let standardButtonTint = standardButtonForeground
    @available(*, deprecated, renamed: "standardDarkButtonBackground")
    static let standardDarkButton = standardDarkButtonBackground
    @available(*, deprecated, renamed: "standardDarkButtonForeground")
    static let standardDarkButtonTint = standardDarkButtonForeground
    
    @available(*, deprecated, renamed: "standardButtonBackgroundForDarkAppearance")
    static let standardDarkAppearanceButton = standardButtonBackground
    @available(*, deprecated, renamed: "standardButtonForegroundForDarkAppearance")
    static let standardDarkAppearanceButtonTint = standardButtonForeground
    @available(*, deprecated, renamed: "standardDarkButtonBackgroundForDarkAppearance")
    static let standardDarkAppearanceDarkButton = standardDarkButtonBackground
    @available(*, deprecated, renamed: "standardDarkButtonForegroundForDarkAppearance")
    static let standardDarkAppearanceDarkButtonTint = standardDarkButtonForeground
    
    @available(*, deprecated, renamed: "standardButtonBackgroundColor")
    static func standardButton(for context: KeyboardContext) -> Color { standardButtonBackground }
    
    @available(*, deprecated, renamed: "standardButtonForegroundColor")
    static func standardButtonTint(for context: KeyboardContext) -> Color { standardButtonForeground }
    
    @available(*, deprecated, renamed: "standardDarkButtonBackgroundColor")
    static func standardDarkButton(for context: KeyboardContext) -> Color { standardDarkButtonBackground }
    
    @available(*, deprecated, renamed: "standardDarkButtonForegroundColor")
    static func standardDarkButtonTint(for context: KeyboardContext) -> Color { standardDarkButtonForeground }
}
