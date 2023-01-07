import SwiftUI

public extension ActionCallout {

    @available(*, deprecated, message: "Use calloutContext initializer instead")
    init(
        context: ActionCalloutContext,
        device: DeviceType = .current,
        style: ActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) {
        #if os(iOS) || os(tvOS) // TODO: Inject
        let keyboardContext = KeyboardInputViewController.shared.keyboardContext
        #else
        let keyboardContext = KeyboardContext()
        #endif
        self.init(
            calloutContext: context,
            keyboardContext: keyboardContext,
            style: style,
            emojiKeyboardStyle: emojiKeyboardStyle
        )
    }
}

public extension InputCallout {

    @available(*, deprecated, message: "Use calloutContext initializer instead")
    init(
        context: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) {
        self.init(
            calloutContext: context,
            keyboardContext: keyboardContext,
            style: style
        )
    }
}

public extension View {

    @available(*, deprecated, renamed: "keyboardActionCallout")
    func actionCallout(
        context: ActionCalloutContext,
        style: ActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) -> some View {
        return ZStack {
            self
            ActionCallout(
                context: context,
                style: style,
                emojiKeyboardStyle: emojiKeyboardStyle
            )
        }.coordinateSpace(name: ActionCalloutContext.coordinateSpace)
    }

    @available(*, deprecated, renamed: "keyboardActionCallout")
    func actionCallout(
        calloutContext: ActionCalloutContext,
        keyboardContext: KeyboardContext,
        style: ActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) -> some View {
        keyboardActionCallout(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext,
            style: style,
            emojiKeyboardStyle: emojiKeyboardStyle
        )
    }

    @available(*, deprecated, renamed: "keyboardCalloutShadow")
    func calloutShadow(style: CalloutStyle) -> some View {
        keyboardCalloutShadow(style: style)
    }

    @available(*, deprecated, renamed: "keyboardInputCallout")
    func inputCallout(
        context: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) -> some View {
        keyboardInputCallout(
            calloutContext: context,
            keyboardContext: keyboardContext,
            style: style
        )
    }

    @available(*, deprecated, renamed: "keyboardInputCallout")
    func inputCallout(
        calloutContext: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) -> some View {
        keyboardInputCallout(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext,
            style: style
        )
    }
}
