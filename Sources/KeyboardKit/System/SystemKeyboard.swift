//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This keyboard can be used to create alphabetic, numeric and
 symbolic keyboards that mimic the native iOS keyboard.

 The keyboard will by default place an ``AutocompleteToolbar``
 above the keyboard, unless you tell it not to. It will also
 replace the keyboard with an ``EmojiCategoryKeyboard`` when
 an ``Keyboard/KeyboardType/emojis`` keyboard is selected.

 There are several ways to create a system keyboard. Use the
 initializers without view builders to use a standard button
 view for each layout item, the `buttonView` initializers to
 customize the full layout item view, and the `buttonContent`
 initializers to customize the button content of each layout
 item, while keeping the standard button shape and style.

 To use the standard button and content views for some items
 when using any of these custom button view builders, simply
 use the ``SystemKeyboardButtonRowItem`` view as button view
 and ``SystemKeyboardButtonContent`` as button content.

 Since the keyboard layout depends on the available keyboard
 width, you must provide this view with a width if you don't
 use the `controller`-based initializers.
 */
public struct SystemKeyboard<ButtonView: View>: View {

    /**
     Create a system keyboard with standard button views.

     This initializer will use a standard button builder for
     every layout item.

     - Parameters:
       - layout: The keyboard layout to use.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - width: The keyboard width.
       - renderBackground: Whether or not to render the background, by default `true`.
     */
    public init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            styleProvider: styleProvider,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            renderBackground: renderBackground,
            buttonView: { item, keyboardWidth, inputWidth in
                Self.standardButtonView(
                    item: item,
                    actionHandler: actionHandler,
                    styleProvider: styleProvider,
                    keyboardContext: keyboardContext,
                    calloutContext: calloutContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth
                )
            }
        )
    }

    /**
     Create a system keyboard with custom button views.

     The provided `buttonView` builder will be used to build
     the full button view for every layout item.

     - Parameters:
       - layout: The keyboard layout to use.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - renderBackground: Whether or not to render the background, by default `true`.
       - width: The keyboard width.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonView: The keyboard button view builder.
     */
    public init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.layout = layout
        self.layoutConfig = .standard(for: keyboardContext)
        self.actionHandler = actionHandler
        self.styleProvider = styleProvider
        self.autocompleteToolbarMode = autocompleteToolbar
        self.autocompleteToolbarAction = autocompleteToolbarAction
        self.keyboardWidth = width
        self.inputWidth = layout.inputWidth(for: width)
        self.buttonView = buttonView
        self.renderBackground = renderBackground
        _autocompleteContext = ObservedObject(wrappedValue: autocompleteContext)
        _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        _calloutContext = ObservedObject(wrappedValue: calloutContext ?? .disabled)
        _actionCalloutContext = ObservedObject(wrappedValue: calloutContext?.actionContext ?? .disabled)
        _inputCalloutContext = ObservedObject(wrappedValue: calloutContext?.inputContext ?? .disabled)
    }

    /**
     Create a system keyboard with custom button content.

     The provided `buttonContent` will be used to create the
     button content for every layout item, while keeping the
     overall shape and style.

     - Parameters:
       - layout: The keyboard layout to use.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - renderBackground: Whether or not to render the background, by default `true`.
       - width: The keyboard width.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonContent: The keyboard button content builder.
     */
    public init<ButtonContentView: View>(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        width: CGFloat,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        self.init(
            layout: layout,
            actionHandler: actionHandler,
            styleProvider: styleProvider,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            renderBackground: renderBackground,
            buttonView: { item, keyboardWidth, inputWidth in
                SystemKeyboardButtonRowItem(
                    content: buttonContent(item),
                    item: item,
                    actionHandler: actionHandler,
                    styleProvider: styleProvider,
                    keyboardContext: keyboardContext,
                    calloutContext: calloutContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth
                )
            }
        )
    }

    #if os(iOS) || os(tvOS)
    /**
     Create a system keyboard with standard button views.

     This initializer will use a standard button builder for
     every layout item.

     - Parameters:
       - controller: The controller to use to resolve required properties.
       - autocompleteToolbar: The autocomplete toolbar mode, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
       - renderBackground: Whether or not to render the background, by default `true`.
     */
    public init(
        controller: KeyboardInputViewController,
        autocompleteToolbar: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        renderBackground: Bool = true
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            actionHandler: controller.keyboardActionHandler,
            styleProvider: controller.keyboardStyleProvider,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width,
            renderBackground: renderBackground
        )
    }

    /**
     Create a system keyboard with custom button views.

     The `buttonView` builder will be used to build the full
     button view for every layout item.

     - Parameters:
       - controller: The controller to use to resolve required properties.
       - autocompleteToolbar: The autocomplete toolbar mode, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonView: The keyboard button view builder.
     */
    public init(
        controller: KeyboardInputViewController,
        autocompleteToolbarMode: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        renderBackground: Bool = true,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            actionHandler: controller.keyboardActionHandler,
            styleProvider: controller.keyboardStyleProvider,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbarMode,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width,
            renderBackground: renderBackground,
            buttonView: buttonView
        )
    }

    /**
     Create a system keyboard with custom button content.

     The provided `buttonContent` will be used to create the
     button content for every layout item, while keeping the
     overall shape and style.

     - Parameters:
       - controller: The controller to use to resolve required properties.
       - autocompleteToolbar: The autocomplete toolbar mode, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonContent: The keyboard button content builder.
     */
    public init<ButtonContentView: View>(
        controller: KeyboardInputViewController,
        autocompleteToolbarMode: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            actionHandler: controller.keyboardActionHandler,
            styleProvider: controller.keyboardStyleProvider,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbarMode,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width,
            renderBackground: renderBackground,
            buttonContent: buttonContent
        )
    }
    #endif

    private let actionHandler: KeyboardActionHandler
    private let styleProvider: KeyboardStyleProvider
    private let autocompleteToolbarMode: AutocompleteToolbarMode
    private let autocompleteToolbarAction: AutocompleteToolbarAction
    private let buttonView: ButtonViewBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let renderBackground: Bool
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayoutConfiguration

    public enum AutocompleteToolbarMode {

        /// Show the autocomplete toolbar if the keyboard context prefers it.
        case automatic

        /// Never show the autocomplete toolbar.
        case none
    }

    public typealias AutocompleteToolbarAction = (AutocompleteSuggestion) -> Void
    public typealias ButtonViewBuilder = (KeyboardLayoutItem, KeyboardWidth, KeyboardItemWidth) -> ButtonView
    public typealias KeyboardWidth = CGFloat
    public typealias KeyboardItemWidth = CGFloat

    private var actionCalloutStyle: KeyboardStyle.ActionCallout {
        var style = styleProvider.actionCalloutStyle
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    private var inputCalloutStyle: KeyboardStyle.InputCallout {
        var style = styleProvider.inputCalloutStyle
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    @ObservedObject
    private var actionCalloutContext: CalloutContext.ActionContext

    @ObservedObject
    private var autocompleteContext: AutocompleteContext

    @ObservedObject
    private var calloutContext: CalloutContext

    @ObservedObject
    private var inputCalloutContext: CalloutContext.InputContext

    @ObservedObject
    private var keyboardContext: KeyboardContext

    public var body: some View {
        VStack(spacing: 0) {
            autocompleteToolbar
            systemKeyboard
        }
        .opacity(shouldShowEmojiKeyboard ? 0 : 1)
        .overlay(emojiKeyboard, alignment: .bottom)
        .foregroundColor(styleProvider.foregroundColor)
        .background(renderBackground ? styleProvider.backgroundStyle.backgroundView : nil)
        .keyboardActionCallout(
            calloutContext: actionCalloutContext,
            keyboardContext: keyboardContext,
            style: actionCalloutStyle,
            emojiKeyboardStyle: .standard(for: keyboardContext)
        )
        .keyboardInputCallout(
            calloutContext: inputCalloutContext,
            keyboardContext: keyboardContext,
            style: inputCalloutStyle
        )
    }
}

private extension SystemKeyboard {
    
    var shouldShowEmojiKeyboard: Bool {
        switch keyboardContext.keyboardType {
        case .emojis: return true
        default: return false
        }
    }
}

private extension SystemKeyboard {

    @ViewBuilder
    var autocompleteToolbar: some View {
        if shouldAddAutocompleteToolbar {
            AutocompleteToolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                style: styleProvider.autocompleteToolbarStyle,
                suggestionAction: autocompleteToolbarAction
            ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Always allocate height
        }
    }
    
    var emojiKeyboard: some View {
        EmojiCategoryKeyboard(
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            style: .standard(for: keyboardContext),
            styleProvider: styleProvider
        )
        .padding(.top)
        .opacity(shouldShowEmojiKeyboard ? 1 : 0)
    }

    var systemKeyboard: some View {
        VStack(spacing: 0) {
            ForEach(Array(layout.itemRows.enumerated()), id: \.offset) {
                items(for: layout, itemRow: $0.element)
            }
        }
        .padding(styleProvider.keyboardEdgeInsets)
        .environment(\.layoutDirection, .leftToRight)
    }

    var shouldAddAutocompleteToolbar: Bool {
        if shouldShowEmojiKeyboard { return true }
        switch autocompleteToolbarMode {
        case .automatic: return true
        case .none: return false
        }
    }
}

public extension SystemKeyboard {

    /**
     The standard ``SystemKeyboardButtonContent`` view, that
     will be used as button content for every layout item.
     */
    static func standardButtonContent(
        item: KeyboardLayoutItem,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext
    ) -> SystemKeyboardButtonContent {
        SystemKeyboardButtonContent(
            action: item.action,
            styleProvider: styleProvider,
            keyboardContext: keyboardContext
        )
    }

    /**
     The standard ``SystemKeyboardButtonRowItem`` view, that
     will be used as button view for every layout item.
     */
    static func standardButtonView(
        item: KeyboardLayoutItem,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        keyboardWidth: KeyboardWidth,
        inputWidth: KeyboardItemWidth
    ) -> SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        SystemKeyboardButtonRowItem(
            content: standardButtonContent(
                item: item,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext),
            item: item,
            actionHandler: actionHandler,
            styleProvider: styleProvider,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth
        )
    }
}

private extension SystemKeyboard {

    func items(for layout: KeyboardLayout, itemRow: KeyboardLayoutItem.Row) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(itemRow.enumerated()), id: \.offset) {
                buttonView($0.element, keyboardWidth, inputWidth)
            }.id(keyboardContext.locale.identifier)
        }
    }
}

#if os(iOS) || os(tvOS)
/**
 `IMPORTANT` In previews, you must provide a custom width to
 get buttons to show up, since there is no shared controller.
 */
struct SystemKeyboard_Previews: PreviewProvider {

    struct Preview: View {

        var controller: KeyboardInputViewController = {
            let controller = KeyboardInputViewController.preview
            controller.keyboardContext.keyboardType = .emojis
            return controller
        }()

        @ViewBuilder
        func previewButton(
            item: KeyboardLayoutItem,
            keyboardWidth: CGFloat,
            inputWidth: CGFloat
        ) -> some View {
            switch item.action {
            case .space:
                Text("This is a space bar replacement")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            default:
                SystemKeyboardButtonRowItem(
                    content: previewButtonContent(item: item),
                    item: item,
                    actionHandler: .preview,
                    styleProvider: controller.keyboardStyleProvider,
                    keyboardContext: controller.keyboardContext,
                    calloutContext: controller.calloutContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth
                )
            }
        }

        @ViewBuilder
        func previewButtonContent(
            item: KeyboardLayoutItem
        ) -> some View {
            switch item.action {
            case .backspace:
                Image(systemName: "trash").foregroundColor(Color.red)
            default:
                SystemKeyboardButtonContent(
                    action: item.action,
                    styleProvider: .preview,
                    keyboardContext: controller.keyboardContext
                )
            }
        }

        var body: some View {
            VStack(spacing: 10) {
                Group {
                    // A standard system keyboard
                    SystemKeyboard(
                        controller: controller,
                        width: UIScreen.main.bounds.width)


                    // A keyboard that replaces the button content
                    SystemKeyboard(
                        controller: controller,
                        width: UIScreen.main.bounds.width,
                        buttonContent: previewButtonContent)

                    // A keyboard that replaces entire button views
                    SystemKeyboard(
                        controller: controller,
                        width: UIScreen.main.bounds.width,
                        buttonView: previewButton)
                }.background(Color.standardKeyboardBackground)
            }
        }
    }


    static var previews: some View {
        Preview()
    }
}
#endif
