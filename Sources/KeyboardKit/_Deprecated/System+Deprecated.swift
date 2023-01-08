import SwiftUI

#if os(iOS) || os(macOS) || os(tvOS)
@available(*, deprecated, message: "Use SystemKeyboardButtonRowItem directly")
public typealias StandardSystemKeyboardButtonView = SystemKeyboardButtonRowItem

@available(*, deprecated, message: "Use SystemKeyboardActionButtonContent directly")
public typealias StandardSystemKeyboardButtonContent = SystemKeyboardActionButtonContent
#endif

public extension SystemKeyboardActionButtonContent {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext
    ) {
        self.init(
            action: action,
            appearance: appearance,
            keyboardContext: context
        )
    }
}

#if os(iOS) || os(macOS)
public extension SystemKeyboardActionButton {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        contentConfig: @escaping ContentConfig
    ) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            keyboardContext: context,
            contentConfig: contentConfig
        )
    }

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext
    ) where Content == SystemKeyboardActionButtonContent {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            keyboardContext: context,
            contentConfig: { $0 }
        )
    }
}
#endif

public extension SystemKeyboardButtonRowItem {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead")
    init(
        content: Content,
        item: KeyboardLayoutItem,
        context: KeyboardContext,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler
    ) {
        self.init(
            content: content,
            item: item,
            keyboardContext: context,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: appearance,
            actionHandler: actionHandler
        )
    }
}

public extension SystemKeyboardButtonText {

    @available(*, deprecated, message: "Use the action initializer instead")
    init(
        text: String,
        isInputAction: Bool
    ) {
        self.init(
            text: text,
            action: isInputAction ? .character("") : .backspace
        )
    }
}

@available(*, deprecated, message: "Use SystemKeyboardButton with SystemKeyboardSpaceContent content")
public typealias SystemKeyboardSpaceButtonContent = SystemKeyboardSpaceContent

@available(*, deprecated, message: "Use SystemKeyboardButton with SystemKeyboardSpaceContent content")
public struct SystemKeyboardSpaceButton<Content: View>: View {

    /**
     Create a system keyboard space button.

     - Parameters:
       - actionHandler: The name of the current locale, if any.
       - appearance: The keyboard appearance to use.
       - context: The keyboard context to which the button should apply.
       - content: The content to display inside the button.
     */
    public init(
        actionHandler: KeyboardActionHandler,
        appearance: KeyboardAppearance,
        context: KeyboardContext,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.context = context
        self.content = content()
    }

    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let context: KeyboardContext
    private let content: Content

    private var action: KeyboardAction { .space }

    @State private var isPressed = false

    public typealias ContentBuilder = () -> Content

    public var body: some View {
        button
            .keyboardGestures(
                for: action,
                actionHandler: actionHandler,
                isPressed: $isPressed)
    }

    private var button: some View {
        SystemKeyboardButton(
            content: content.frame(maxWidth: .infinity),
            style: buttonStyle)
    }

    private var buttonStyle: KeyboardButtonStyle {
        appearance.buttonStyle(
            for: action,
            isPressed: isPressed)
    }
}
