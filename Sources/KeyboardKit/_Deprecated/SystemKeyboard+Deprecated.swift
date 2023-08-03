import Foundation
import SwiftUI

@available(*, deprecated, message: "Use the styleProvider initializer instead.")
public extension SystemKeyboard {
 
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            styleProvider: appearance,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            renderBackground: renderBackground
        )
    }

    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            styleProvider: appearance,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            renderBackground: renderBackground,
            buttonView: buttonView
        )
    }

    init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            styleProvider: appearance,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            renderBackground: renderBackground,
            buttonContent: buttonContent
        )
    }
}

public extension SystemKeyboard {
    
    @available(*, deprecated, message: "Use the styleProvider function instead.")
    static func standardButtonContent(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) -> SystemKeyboardButtonContent {
        standardButtonContent(
            item: item,
            styleProvider: appearance,
            keyboardContext: keyboardContext
        )
    }
    
    @available(*, deprecated, message: "Use the styleProvider function instead.")
    static func standardButtonView(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        keyboardWidth: KeyboardWidth,
        inputWidth: KeyboardItemWidth
    ) -> SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        standardButtonView(
            item: item,
            actionHandler: actionHandler,
            styleProvider: appearance,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth
        )
    }
}

@available(*, deprecated, message: "Use the styleProvider initializer instead.")
public extension SystemKeyboardButton {
    
    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        appearance: KeyboardAppearance,
        contentConfig: @escaping ContentConfig
    ) {
        self.init(
            action: action,
            actionHandler: actionHandler,
            styleProvider: appearance,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            contentConfig: contentConfig
        )
    }

    init(
        action: KeyboardAction,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        appearance: KeyboardAppearance
    ) where Content == SystemKeyboardButtonContent {
        self.init(
            action: action,
            actionHandler: actionHandler,
            styleProvider: appearance,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext
        )
    }
}

@available(*, deprecated, message: "Use the styleProvider initializer instead.")
public extension SystemKeyboardButtonContent {
    
    init(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) {
        self.init(
            action: action,
            styleProvider: appearance,
            keyboardContext: keyboardContext
        )
    }
}

@available(*, deprecated, message: "Use the styleProvider initializer instead.")
public extension SystemKeyboardButtonRowItem {
    
    init(
        content: Content,
        item: KeyboardLayoutItem,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat,
        appearance: KeyboardAppearance
    ) {
        self.init(
            content: content,
            item: item,
            actionHandler: actionHandler,
            styleProvider: appearance,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth
        )
    }
}

@available(*, deprecated, message: "These extensions are no longer used and will be removed in KK 8.0")
public extension SystemKeyboardLayoutProvider {

    /**
     The number of alphabetic inputs on each input row.
     */
    var alphabeticInputCount: [Int] {
        inputSetProvider.alphabeticInputSet.rows.map { $0.count }
    }

    /**
     Whether or not the current alphabetic input set has the
     provided number of inputs.
     */
    func hasAlphabeticInputCount(_ rows: [Int]) -> Bool {
        Array(alphabeticInputCount.prefix(rows.count)) == rows
    }

    /**
     Whether or not the current input set is alphabetic with
     the provided number of inputs.
     */
    func isAlphabeticWithInputCount(_ context: KeyboardContext, _ rows: [Int]) -> Bool {
        context.isAlphabetic && hasAlphabeticInputCount(rows)
    }
}

private extension KeyboardContext {

    /// This property makes the context checks above shorter.
    var isAlphabetic: Bool {
        keyboardType.isAlphabetic
    }
}
