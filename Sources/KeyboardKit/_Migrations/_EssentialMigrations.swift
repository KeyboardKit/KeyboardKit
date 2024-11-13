import Foundation
import SwiftUI

public extension Keyboard {

    @available(*, deprecated, renamed: "KeyboardCase", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Case = KeyboardCase
}

public extension Keyboard.KeyboardType {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    static func alphabetic(_ case: Keyboard.KeyboardCase) -> Self {
        .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check.")
    var isAlphabetic: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    var isAlphabeticCapsLocked: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    var isAlphabeticUppercased: Bool {
        self == .alphabetic
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Keyboard type and case have been separated.")
    func isAlphabetic(_ case: Keyboard.KeyboardCase) -> Bool {
        self == .alphabetic
    }
}

@available(*, deprecated, renamed: "Keyboard.Settings", message: "Migration Deprecation, will be removed in 9.1!")
public typealias KeyboardSettings = Keyboard.Settings

public extension KeyboardView where CollapsedView == KeyboardView.StandardCollapsedView {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! You must define a collapsed view.")
    init(
        layout: KeyboardLayout? = nil,
        state: Keyboard.State,
        services: Keyboard.Services,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        let serviceLayout = services.layoutService
            .keyboardLayout(for: state.keyboardContext)
        self.init(
            layout: layout ?? serviceLayout,
            actionHandler: services.actionHandler,
            repeatTimer: services.repeatGestureTimer,
            styleService: services.styleService,
            keyboardContext: state.keyboardContext,
            autocompleteContext: state.autocompleteContext,
            calloutContext: state.calloutContext,
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView,
            collapsedView: { $0.view },
            emojiKeyboard: emojiKeyboard,
            toolbar: toolbar
        )
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! You must define a collapsed view.")
    init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        autocompleteContext: AutocompleteContext,
        calloutContext: KeyboardCalloutContext,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            repeatTimer: repeatTimer,
            styleService: styleService,
            keyboardContext: keyboardContext,
            autocompleteContext: autocompleteContext,
            calloutContext: calloutContext,
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView,
            collapsedView: { $0.view },
            emojiKeyboard: emojiKeyboard,
            toolbar: toolbar
        )
    }
}

public extension Keyboard.KeyboardCase {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check. instead")
    var isCapsLocked: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: false
        }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check. instead")
    var isLowercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: false
        case .lowercased: true
        case .uppercased: false
        }
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Just use an equality check. instead")
    var isUppercased: Bool {
        switch self {
        case .auto: false
        case .capsLocked: true
        case .lowercased: false
        case .uppercased: true
        }
    }
}
