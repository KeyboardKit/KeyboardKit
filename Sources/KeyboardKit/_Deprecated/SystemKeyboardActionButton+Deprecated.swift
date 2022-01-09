import Foundation

public extension SystemKeyboardActionButton {
    
}

public extension SystemKeyboardActionButton where Content == SystemKeyboardActionButtonContent {
    
    @available(*, deprecated, message: "This init is deprecared. Use the new one, where context precedes appearance instead.")
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        appearance: KeyboardAppearance) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            appearance: appearance,
            context: context,
            contentConfig: { $0 })
    }
}
