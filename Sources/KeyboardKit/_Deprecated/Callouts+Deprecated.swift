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

    @available(*, deprecated, message: "Use calloutContext function instead")
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


    @available(*, deprecated, message: "Use calloutContext function instead")
    func inputCallout(
        context: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) -> some View {
        ZStack {
            self
            InputCallout(
                context: context,
                keyboardContext: keyboardContext,
                style: style)
        }.coordinateSpace(name: InputCallout.coordinateSpace)
    }
}
