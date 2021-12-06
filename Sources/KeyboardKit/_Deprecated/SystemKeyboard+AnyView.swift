import CoreGraphics
import SwiftUI

public extension SystemKeyboard where ButtonView == AnyView {

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
        width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
        buttonBuilder: @escaping ButtonContentBuilder<AnyView> = standardButtonBuilder) {
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
