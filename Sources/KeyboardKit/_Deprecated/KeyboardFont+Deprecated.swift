import SwiftUI

@available(*, deprecated, message: "Use KeyboardAction.standardButtonFont instead.")
public extension KeyboardFont {

    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont {
        action.standardButtonFont(for: context)
    }
}

public extension KeyboardFont {

    @available(*, deprecated, message: "Use KeyboardAction.standardButtonFontSize instead.")
    static func standardSize(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat {
        action.standardButtonFontSize(for: context)
    }

    @available(*, deprecated, message: "Use KeyboardAction.standardButtonFontWeight instead.")
    static func standardWeight(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> KeyboardFont.FontWeight? {
        action.standardButtonFontWeight(for: context)
    }
}
