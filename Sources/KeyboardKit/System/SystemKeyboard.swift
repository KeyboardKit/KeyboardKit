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
 
 The `buttonContent` and `buttonView` parameters can be used
 to customize the content or the entire view of any keyboard
 button. These functions are called for each layout item and
 its default view, at which you can just return the standard
 view with `{ item, view in view }` or `{ $1 }` or customize
 it like this:
 
 ```swift
 SystemKeyboard(
     controller: controller,
     buttonContent: { item, view in
         switch item.action {
         case .backspace: Image(systemName: "trash")
         default: view
         }
     },
     buttonView: { item, view in
         switch item.action {
         case .space: Text("This is true, empty space")
             .opacity(0)
             .frame(maxWidth: .infinity)
         default: view
         }
     }
 )
 ```
 
 In the code above, the backspace content is replaced with a
 trashbin and the entire spacebar is replaced by transparent
 text that takes up as much space as needed.
 
 This view will by place an ``Autocomplete/Toolbar`` topmost,
 unless we explicitly tell it not to. It will also overlay a
 full emoji keyboard over the entire view, when the keyboard
 context's ``KeyboardContext/keyboardType`` is currently set
 to ``Keyboard/KeyboardType/emojis``.

 Since the keyboard layout depends on the available keyboard
 width, you must pass in a `width`, if you don't want to use
 the current controller's width.
 */
public struct SystemKeyboard<ButtonContent: View, ButtonView: View>: View {

    /**
     Create a system keyboard with custom button views.

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
       - buttonContent: The keyboard button content view builder.
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
        width: KeyboardWidth,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
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
        self.buttonContent = buttonContent
        self.buttonView = buttonView
        self.renderBackground = renderBackground
        _autocompleteContext = ObservedObject(wrappedValue: autocompleteContext)
        _calloutContext = ObservedObject(wrappedValue: calloutContext ?? .disabled)
        _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
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
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
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
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView
        )
    }
    #endif

    private let actionHandler: KeyboardActionHandler
    private let styleProvider: KeyboardStyleProvider
    private let autocompleteToolbarMode: AutocompleteToolbarMode
    private let autocompleteToolbarAction: AutocompleteToolbarAction
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let renderBackground: Bool
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayoutConfiguration
    
    private let buttonContent: ButtonContentBuilder
    private let buttonView: ButtonViewBuilder
    
    public enum AutocompleteToolbarMode {

        /// Show the autocomplete toolbar if the keyboard context prefers it.
        case automatic

        /// Never show the autocomplete toolbar.
        case none
    }

    public typealias ButtonContentBuilder = (KeyboardLayoutItem, _ standard: KeyboardButton.Content) -> ButtonContent
    public typealias ButtonViewBuilder = (KeyboardLayoutItem, _ standard: SystemKeyboardItem<ButtonContent>) -> ButtonView
    
    public typealias AutocompleteToolbarAction = (Autocomplete.Suggestion) -> Void
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
    private var autocompleteContext: AutocompleteContext

    @ObservedObject
    private var calloutContext: CalloutContext

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
        .keyboardCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext,
            actionCalloutStyle: actionCalloutStyle,
            inputCalloutStyle: inputCalloutStyle
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
            Autocomplete.Toolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                style: styleProvider.autocompleteToolbarStyle,
                suggestionAction: autocompleteToolbarAction
            ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Always allocate height
        }
    }
    
    // TODO: Turn into an init parameter
    var emojiKeyboard: some View {
        EmptyView()
        // Emojis.Keyboard(
        //     actionHandler: actionHandler,
        //     keyboardContext: keyboardContext,
        //     calloutContext: calloutContext,
        //     style: .standard(for: keyboardContext),
        //     styleProvider: styleProvider
        // )
        // .padding(.top)
        // .opacity(shouldShowEmojiKeyboard ? 1 : 0)
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

private extension SystemKeyboard {
    
    func buttonContent(
        for item: KeyboardLayoutItem
    ) -> ButtonContent {
        buttonContent(
            item,
            KeyboardButton.Content(
                action: item.action,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext
            )
        )
    }

    /**
     The standard ``SystemKeyboardItem`` view, that
     will be used as button view for every layout item.
     */
    func buttonView(
        for item: KeyboardLayoutItem
    ) -> ButtonView {
        buttonView(
            item,
            SystemKeyboardItem(
                item: item,
                actionHandler: actionHandler,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                content: buttonContent(for: item)
            )
        )
    }
}

private extension SystemKeyboard {

    func items(for layout: KeyboardLayout, itemRow: KeyboardLayoutItem.Row) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(itemRow.enumerated()), id: \.offset) {
                buttonView(for: $0.element)
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
            // controller.keyboardContext.keyboardType = .emojis
            return controller
        }()

        var body: some View {
            VStack(spacing: 10) {
                Group {
                    SystemKeyboard(
                        controller: controller,
                        buttonContent: { $1 },
                        buttonView: { $1 }
                    )
                    
                    SystemKeyboard(
                        controller: controller,
                        buttonContent: {
                            switch $0.action {
                            case .backspace:
                                Image(systemName: "trash").foregroundColor(Color.red)
                            default: $1
                            }
                        },
                        buttonView: {
                            switch $0.action {
                            case .space:
                                Text("This is a space bar replacement")
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                            default: $1
                            }
                        }
                    )
                }.background(Color.standardKeyboardBackground)
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
