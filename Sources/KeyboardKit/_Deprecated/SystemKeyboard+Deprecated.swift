import CoreGraphics
import SwiftUI

public extension SystemKeyboard {
    
    @available(*, deprecated, message: "buttonViewBuilder has been renamed to buttonView, context to keyboardContext, inputContext to inputCalloutContext and secondaryInputContext to actionCalloutContext")
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonViewBuilder: @escaping ButtonViewBuilder) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            keyboardContext: context,
            actionCalloutContext: secondaryInputContext,
            inputCalloutContext: inputContext,
            buttonView: buttonViewBuilder)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<AnyView> {
    
    @available(*, deprecated, message: "buttonContentBuilder has been renamed to buttonContent, context to keyboardContext, inputContext to inputCalloutContext and secondaryInputContext to actionCalloutContext")
    init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonContentBuilder: @escaping (KeyboardLayoutItem) -> ButtonContentView) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            keyboardContext: context,
            actionCalloutContext: secondaryInputContext,
            inputCalloutContext: inputContext,
            width: width,
            buttonContent: buttonContentBuilder)
    }
    
    @available(*, deprecated, message: "buttonContentBuilder has been renamed to buttonContent")
    init<ButtonContentView: View>(
        controller: KeyboardInputViewController = .shared,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonContentBuilder: @escaping (KeyboardLayoutItem) -> ButtonContentView) {
            self.init(
                controller: controller,
                width: width,
                buttonContent: buttonContentBuilder)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
    
    @available(*, deprecated, message: "context has been renamed to keyboardContext, inputContext to inputCalloutContext and secondaryInputContext to actionCalloutContext")
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: ActionCalloutContext?,
        width: CGFloat = standardKeyboardWidth) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            keyboardContext: context,
            actionCalloutContext: secondaryInputContext,
            inputCalloutContext: inputContext,
            width: width)
    }
}


public extension SystemKeyboard where ButtonView == AnyView {

    @available(*, deprecated, message: "Use the new generic initializers instead.")
    typealias ButtonContentBuilder = (KeyboardAction, KeyboardAppearance, KeyboardContext) -> AnyView
    
    /**
     This deprecated initializer uses standard buttons views
     of the type ``SystemKeyboardButtonRowItem`` in which it
     wraps the `buttonBuilder` views.
     */
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        buttonBuilder: @escaping ButtonContentBuilder) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            context: context,
            inputContext: inputContext,
            secondaryInputContext: secondaryInputContext,
            width: width,
            buttonViewBuilder: { item, keyboardWidth, inputWidth in
                AnyView(
                    SystemKeyboardButtonRowItem(
                        content: buttonBuilder(item.action, appearance, context),
                        item: item,
                        context: context,
                        keyboardWidth: keyboardWidth,
                        inputWidth: inputWidth,
                        appearance: appearance,
                        actionHandler: actionHandler
                    )
                )
            }
        )
    }
    
    @available(*, deprecated, message: "Use the new generic initializers instead.")
    static func standardButtonBuilder(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext) -> AnyView {
        AnyView(SystemKeyboardActionButtonContent(
            action: action,
            appearance: appearance,
            context: context))
    }
}
