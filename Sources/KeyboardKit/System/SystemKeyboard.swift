//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This keyboard can be used to create alphabetic, numeric and
 symbolic keyboards that mimic the native iOS keyboard.

 The keyboard will by default place an ``AutocompleteToolbar``
 above the keyboard, unless you tell it not to. It will also
 replace the keyboard with an ``EmojiCategoryKeyboard`` when
 ``KeyboardContext/keyboardType`` is ``KeyboardType/emojis``.

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
       - appearance: The keyboard appearance to use.
       - actionHandler: The action handler to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - width: The keyboard width.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            buttonView: { item, keyboardWidth, inputWidth in
                Self.standardButtonView(
                    item: item,
                    appearance: appearance,
                    actionHandler: actionHandler,
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
       - appearance: The keyboard appearance to use.
       - actionHandler: The action handler to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - width: The keyboard width.
       - buttonView: The keyboard button view builder.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.layout = layout
        self.layoutConfig = .standard(for: keyboardContext)
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.autocompleteToolbarMode = autocompleteToolbar
        self.autocompleteToolbarAction = autocompleteToolbarAction
        self.keyboardWidth = width
        self.inputWidth = layout.inputWidth(for: width)
        self.buttonView = buttonView
        _autocompleteContext = ObservedObject(wrappedValue: autocompleteContext)
        _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        _calloutContext = ObservedObject(wrappedValue: calloutContext ?? .disabled)
        _actionCalloutContext = ObservedObject(wrappedValue: calloutContext?.action ?? .disabled)
        _inputCalloutContext = ObservedObject(wrappedValue: calloutContext?.input ?? .disabled)
    }

    /**
     Create a system keyboard with custom button content.

     The provided `buttonContent` will be used to create the
     button content for every layout item, while keeping the
     overall shape and style.

     - Parameters:
       - layout: The keyboard layout to use.
       - appearance: The keyboard appearance to use.
       - actionHandler: The action handler to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteToolbar: The autocomplete toolbar mode to use.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion.
       - keyboardContext: The keyboard context to use.
       - calloutContext: The callout context to use.
       - width: The keyboard width.
       - autocompleteToolbarMode: The display mode of the autocomplete toolbar, by default ``AutocompleteToolbarMode/automatic``.
       - buttonContent: The keyboard button content builder.
     */
    public init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteToolbar: AutocompleteToolbarMode,
        autocompleteToolbarAction: @escaping AutocompleteToolbarAction,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        width: CGFloat,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            autocompleteContext: autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            width: width,
            buttonView: { item, keyboardWidth, inputWidth in
                SystemKeyboardButtonRowItem(
                    content: buttonContent(item),
                    item: item,
                    actionHandler: actionHandler,
                    keyboardContext: keyboardContext,
                    calloutContext: calloutContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth,
                    appearance: appearance
                )
            }
        )
    }

    /**
     Create a system keyboard with standard button views.

     This initializer will use a standard button builder for
     every layout item.

     - Parameters:
       - controller: The controller to use to resolve required properties.
       - autocompleteToolbarMode: The display mode of the autocomplete toolbar, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
     */
    public init(
        controller: KeyboardInputViewController,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        autocompleteToolbar: AutocompleteToolbarMode = .automatic,
        width: CGFloat? = nil
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbar,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width
        )
    }

    /**
     Create a system keyboard with custom button views.

     The `buttonView` builder will be used to build the full
     button view for every layout item.

     - Parameters:
       - controller: The controller to use to resolve required properties.
       - autocompleteToolbar: The display mode of the autocomplete toolbar, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
       - buttonView: The keyboard button view builder.
     */
    public init(
        controller: KeyboardInputViewController,
        autocompleteToolbarMode: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbarMode,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width,
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
       - autocompleteToolbar: The display mode of the autocomplete toolbar, by default ``AutocompleteToolbarMode/automatic``.
       - autocompleteToolbarAction: The action to trigger when tapping an autocomplete suggestion, by default ``KeyboardInputViewController/insertAutocompleteSuggestion(_:)``.
       - width: The keyboard width, by default the width of the controller's view.
       - buttonContent: The keyboard button content builder.
     */
    public init<ButtonContentView: View>(
        controller: KeyboardInputViewController,
        autocompleteToolbarMode: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            autocompleteContext: controller.autocompleteContext,
            autocompleteToolbar: autocompleteToolbarMode,
            autocompleteToolbarAction: autocompleteToolbarAction ?? { [weak controller] suggestion in
                controller?.insertAutocompleteSuggestion(suggestion)
            },
            keyboardContext: controller.keyboardContext,
            calloutContext: controller.calloutContext,
            width: width ?? controller.view.frame.width,
            buttonContent: buttonContent
        )
    }

    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let autocompleteToolbarMode: AutocompleteToolbarMode
    private let autocompleteToolbarAction: AutocompleteToolbarAction
    private let buttonView: ButtonViewBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
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

    private var actionCalloutStyle: KeyboardActionCalloutStyle {
        var style = appearance.actionCalloutStyle
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    private var inputCalloutStyle: KeyboardInputCalloutStyle {
        var style = appearance.inputCalloutStyle
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    @ObservedObject
    private var actionCalloutContext: ActionCalloutContext

    @ObservedObject
    private var autocompleteContext: AutocompleteContext

    @ObservedObject
    private var calloutContext: KeyboardCalloutContext

    @ObservedObject
    private var inputCalloutContext: InputCalloutContext

    @ObservedObject
    private var keyboardContext: KeyboardContext

    public var body: some View {
        VStack(spacing: 0) {
            autocompleteToolbar
            keyboardView
        }.background(appearance.backgroundStyle.backgroundView)
    }
}

private extension SystemKeyboard {

    @ViewBuilder
    var autocompleteToolbar: some View {
        if shouldAddAutocompleteToolbar {
            AutocompleteToolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                style: appearance.autocompleteToolbarStyle,
                suggestionAction: autocompleteToolbarAction
            ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Always allocate height
        }
    }

    var keyboardView: some View {
        keyboardViewContent
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

    @ViewBuilder
    var keyboardViewContent: some View {
        switch keyboardContext.keyboardType {
        case .emojis: emojiKeyboard
        default: systemKeyboard
        }
    }

    var shouldAddAutocompleteToolbar: Bool {
        if keyboardContext.keyboardType == .emojis { return false }
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
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) -> SystemKeyboardButtonContent {
        SystemKeyboardButtonContent(
            action: item.action,
            appearance: appearance,
            keyboardContext: keyboardContext
        )
    }

    /**
     The standard ``SystemKeyboardButtonRowItem`` view, that
     will be used as button view for every layout item.
     */
    static func standardButtonView(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        keyboardWidth: KeyboardWidth,
        inputWidth: KeyboardItemWidth
    ) -> SystemKeyboardButtonRowItem<SystemKeyboardButtonContent> {
        SystemKeyboardButtonRowItem(
            content: standardButtonContent(
                item: item,
                appearance: appearance,
                keyboardContext: keyboardContext),
            item: item,
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: appearance
        )
    }
}

private extension SystemKeyboard {

    var emojiKeyboard: some View {
        EmojiCategoryKeyboard(
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            calloutContext: calloutContext,
            appearance: appearance,
            style: .standard(for: keyboardContext)
        ).padding(.top)
    }

    var systemKeyboard: some View {
        VStack(spacing: 0) {
            itemRows(for: layout)
        }
        .padding(appearance.keyboardEdgeInsets)
        .environment(\.layoutDirection, .leftToRight)
    }
}

private extension SystemKeyboard {

    func itemRows(for layout: KeyboardLayout) -> some View {
        ForEach(Array(layout.itemRows.enumerated()), id: \.offset) {
            items(for: layout, itemRow: $0.element)
        }
    }

    func items(for layout: KeyboardLayout, itemRow: KeyboardLayoutItemRow) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(itemRow.enumerated()), id: \.offset) {
                buttonView($0.element, keyboardWidth, inputWidth)
            }.id(keyboardContext.locale.identifier)
        }
    }
}

/**
 `IMPORTANT` In previews, you must provide a custom width to
 get buttons to show up, since there is no shared controller.
 */
struct SystemKeyboard_Previews: PreviewProvider {

    static var context: KeyboardContext = {
        let context = KeyboardContext()
        context.locales = KeyboardLocale.allCases.map { $0.locale }
        context.localePresentationLocale = KeyboardLocale.swedish.locale
        context.spaceLongPressBehavior = .openLocaleContextMenu
        return context
    }()

    @ViewBuilder
    static func previewButton(
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
                keyboardContext: context,
                calloutContext: .preview,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                appearance: .preview
            )
        }
    }

    @ViewBuilder
    static func previewButtonContent(
        item: KeyboardLayoutItem
    ) -> some View {
        switch item.action {
        case .backspace:
            Image(systemName: "trash").foregroundColor(Color.red)
        default:
            SystemKeyboardButtonContent(
                action: item.action,
                appearance: .preview,
                keyboardContext: context
            )
        }
    }

    static var previews: some View {
        VStack(spacing: 10) {

            // A standard system keyboard
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                autocompleteContext: .init(),
                autocompleteToolbar: .automatic,
                autocompleteToolbarAction: { _ in },
                keyboardContext: context,
                calloutContext: nil,
                width: UIScreen.main.bounds.width)


            // A keyboard that replaces the button content
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                autocompleteContext: .init(),
                autocompleteToolbar: .none,
                autocompleteToolbarAction: { _ in },
                keyboardContext: context,
                calloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonContent: previewButtonContent)

            // A keyboard that replaces entire button views
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                autocompleteContext: .init(),
                autocompleteToolbar: .none,
                autocompleteToolbarAction: { _ in },
                keyboardContext: context,
                calloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonView: previewButton)
        }.background(Color.yellow)
    }
}
#endif
