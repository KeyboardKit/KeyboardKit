import SwiftUI

public extension Keyboard.ButtonStyle {

    @available(*, deprecated, message: "Use ``KeyboardAction.standardButtonStyle(for:) instead")
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction,
        isPressed: Bool = false
    ) -> Keyboard.ButtonStyle {
        action.standardButtonStyle(for: context)
    }
}

public extension Keyboard.ButtonStyle {

    @available(*, deprecated, message: "Use ``KeyboardAction.standardButtonContentInsets(for:) instead")
    static func standardContentInsets(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> EdgeInsets {
        action.standardButtonContentInsets(for: context)
    }

    @available(*, deprecated, message: "Use ``KeyboardAction.standardButtonCornerRadius(for:) instead")
    static func standardCornerRadius(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> CGFloat {
        action.standardButtonCornerRadius(for: context)
    }
}

public extension Keyboard.ButtonBorderStyle {

    @available(*, deprecated, message: "Use ``KeyboardAction.standardButtonBorderStyle(for:) instead")
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Self {
        action.standardButtonBorderStyle(for: context)
    }
}

public extension Keyboard.ButtonShadowStyle {

    @available(*, deprecated, message: "Use ``KeyboardAction.standardButtonShadowStyle(for:) instead")
    static func standard(
        for context: KeyboardContext,
        action: KeyboardAction
    ) -> Keyboard.ButtonShadowStyle {
        action.standardButtonShadowStyle(for: context)
    }
}
