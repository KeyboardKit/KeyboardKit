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
 
 KeyboardKit will by default use a standard ``SystemKeyboard``
 if you don't provide a custom view. So, if you just want to
 use such a standard keyboard, you don't have to do anything.
 
 If you want to customize the system keyboard, or wrap it in
 another view like a `VStack`, you just have to override the
 ``KeyboardInputViewController/viewWillSetupKeyboard()`` and
 call any of the `setup(with:)` functions with a custom view.
 
 The `buttonContent` and `buttonView` parameters can be used
 to customize the content or the entire view of any button.
 
 The `emojiKeyboard` parameter defines the view that will be
 used for the ``Keyboard/KeyboardType/emojis`` keyboard type.
 An `EmptyView` is used as the default view, but KeyboardKit
 Pro unlocks an **EmojiKeyboard** that you can use.
 
 The `toolbar` parameter defines the view that will be added
 above the keyboard. An ``AutocompleteToolbar`` will be used
 as the default view.
 
 To use the standard views for all these views, you can just
 return `{ $0.view }`, or `{ params in params.view }` if you
 prefer more expressive code:
 
 ```swift
 SystemKeyboard(
     controller: controller,
     buttonContent: { params in params.view },
     buttonView: { $0.view },
     emojiKeyboard: { $0.view },
     toolbar: { $0.view }
 )
 ```
 
 The various view builders provide even more parameters than
 just the default view. For instance, the button content and
 button view builders get the full layout item as well.
 
 To customize or replace the standard content and item views
 for any item, just provide custom builders like this:
 
 ```swift
 SystemKeyboard(
     controller: controller,
     buttonContent: { params in
         switch params.item.action {
         case .backspace: Image(systemName: "trash")
         default: params.view
         }
     },
     buttonView: { params in
         switch params.item.action {
         case .space: Text("This is true, empty space")
             .opacity(0)
             .frame(maxWidth: .infinity)
         default: params.view
         }
     },
     emojiKeyboard: { _ in Color.red },
     toolbar: { _ in Color.yellow }
 )
 ```
 
 In the code above, the backspace content is replaced with a
 trashbin and the entire spacebar is replaced by transparent
 text that takes up as much space as needed.
 
 This view will place an ``AutocompleteToolbar`` topmost, if
 we explicitly tell it not to. It will also overlay an emoji
 keyboard over the keyboard, whenever the keyboard context's
 ``KeyboardContext/keyboardType`` is set to `.emojis`.

 Since the keyboard layout depends on the available keyboard
 width, you must pass in a `width`, if you don't want to use
 the current controller's width.
 
 You can take a look at the source code of the various views
 in the library for inspiration.
 */
public struct SystemKeyboard<
    ButtonContent: View,
    ButtonView: View,
    EmojiKeyboard: View,
    Toolbar: View>: View {

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
       - buttonContent: The keyboard button content view to use for an item.
       - buttonView: The keyboard button view to use for an item.
       - emojiKeyboard: The emoji keyboard to replace the keyboard with when the keyboard type becomes `.emoji`.
       - toolbar: The keyboard toolbar to add above the keyboard.
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
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        self.layout = layout
        self.layoutConfig = .standard(for: keyboardContext)
        self.actionHandler = actionHandler
        self.styleProvider = styleProvider
        self.autocompleteToolbarMode = autocompleteToolbar
        self.autocompleteToolbarAction = autocompleteToolbarAction
        self.keyboardWidth = width
        self.inputWidth = layout.inputWidth(for: width)
        self.renderBackground = renderBackground
        self.buttonContentBuilder = buttonContent
        self.buttonViewBuilder = buttonView
        self.emojiKeyboardBuilder = emojiKeyboard
        self.toolbarBuilder = toolbar
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
       - buttonContent: The keyboard button content view to use for an item.
       - buttonView: The keyboard button view to use for an item.
       - emojiKeyboard: The emoji keyboard to replace the keyboard with when the keyboard type becomes `.emoji`.
       - toolbar: The keyboard toolbar to add above the keyboard.
     */
    public init(
        controller: KeyboardInputViewController,
        autocompleteToolbar: AutocompleteToolbarMode = .automatic,
        autocompleteToolbarAction: AutocompleteToolbarAction? = nil,
        width: CGFloat? = nil,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
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
            buttonView: buttonView,
            emojiKeyboard: emojiKeyboard,
            toolbar: toolbar
        )
    }
    #endif

    
    /// This typealias defines button content builder params.
    public typealias ButtonContentParams = (
        item: KeyboardLayout.Item,
        view: KeyboardButton.Content)
    
    /// This typealias defines button view builder params.
    public typealias ButtonViewParams = (
        item: KeyboardLayout.Item,
        view: SystemKeyboardItem<ButtonContent>)
    
    /// This typealias defines emoji keyboard builder params.
    public typealias EmojiKeyboardParams = (
        style: KeyboardStyle.EmojiKeyboard,
        view: EmptyView)
    
    /// This typealias defines toolbar builder params.
    public typealias ToolbarParams = (
        autocompleteAction: (Autocomplete.Suggestion) -> Void,
        style: KeyboardStyle.AutocompleteToolbar,
        view: AutocompleteToolbar<Autocomplete.ToolbarItem, Autocomplete.ToolbarSeparator>)

    
    /// This typealias defines a button content builder.
    public typealias ButtonContentBuilder = (ButtonContentParams) -> ButtonContent
    
    /// This typealias defines a button view builder.
    public typealias ButtonViewBuilder = (ButtonViewParams) -> ButtonView
    
    /// This typealias defines a emoji keyboard builder.
    public typealias EmojiKeyboardBuilder = (EmojiKeyboardParams) -> EmojiKeyboard
    
    /// This typealias defines a toolbar builder.
    public typealias ToolbarBuilder = (ToolbarParams) -> Toolbar

    
    private let actionHandler: KeyboardActionHandler
    private let styleProvider: KeyboardStyleProvider
    private let autocompleteToolbarMode: AutocompleteToolbarMode
    private let autocompleteToolbarAction: AutocompleteToolbarAction
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let renderBackground: Bool
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayout.Configuration
    
    private let buttonContentBuilder: ButtonContentBuilder
    private let buttonViewBuilder: ButtonViewBuilder
    private let emojiKeyboardBuilder: EmojiKeyboardBuilder
    private let toolbarBuilder: ToolbarBuilder
    
    public enum AutocompleteToolbarMode {

        /// Show the autocomplete toolbar if the keyboard context prefers it.
        case automatic

        /// Never show the autocomplete toolbar.
        case none
    }

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
            toolbar()
            systemKeyboard
        }
        .opacity(shouldShowEmojiKeyboard ? 0 : 1)
        .overlay(emojiKeyboard(), alignment: .bottom)
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
        for item: KeyboardLayout.Item
    ) -> ButtonContent {
        buttonContentBuilder((
            item: item,
            view: KeyboardButton.Content(
                action: item.action,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext
            )
        ))
    }
    
    func buttonView(
        for item: KeyboardLayout.Item
    ) -> ButtonView {
        buttonViewBuilder((
            item: item,
            view: SystemKeyboardItem(
                item: item,
                actionHandler: actionHandler,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                content: buttonContent(for: item)
            )
        ))
    }
    
    func emojiKeyboard() -> some View {
        emojiKeyboardBuilder((
            style: KeyboardStyle.EmojiKeyboard.standard(for: keyboardContext),
            view: EmptyView()
        ))
        .padding(.top)
        .opacity(shouldShowEmojiKeyboard ? 1 : 0)
    }
    
    func toolbar() -> some View {
        toolbarBuilder((
            autocompleteAction: autocompleteToolbarAction,
            style: styleProvider.autocompleteToolbarStyle,
            view: AutocompleteToolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                style: styleProvider.autocompleteToolbarStyle,
                suggestionAction: autocompleteToolbarAction
            )
        ))
    }
}

private extension SystemKeyboard {

    func items(for layout: KeyboardLayout, itemRow: KeyboardLayout.ItemRow) -> some View {
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
            controller.autocompleteContext.suggestions = [
                .init(text: "Foo"),
                .init(text: "Bar", isAutocorrect: true),
                .init(text: "Baz")
            ]
            // controller.keyboardContext.keyboardType = .emojis
            return controller
        }()
        
        func customEmojiKeyboard(_ color: Color) -> some View {
            Button {
                controller.keyboardContext.keyboardType = .alphabetic(.lowercased)
            } label: {
                color
            }
        }

        var body: some View {
            VStack(spacing: 10) {
                Group {
                    SystemKeyboard(
                        controller: controller,
                        buttonContent: { $0.view },
                        buttonView: { $0.view },
                        emojiKeyboard: { $0.view },
                        toolbar: { $0.view }
                    )
                    
                    SystemKeyboard(
                        controller: controller,
                        buttonContent: { param in
                            switch param.item.action {
                            case .backspace:
                                Image(systemName: "trash").foregroundColor(Color.red)
                            default: param.view
                            }
                        },
                        buttonView: { param in
                            switch param.item.action {
                            case .space:
                                Text("This is a space bar replacement")
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                            default: param.view
                            }
                        },
                        emojiKeyboard: { _ in
                            customEmojiKeyboard(.yellow)
                        },
                        toolbar: { $0.view }
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
