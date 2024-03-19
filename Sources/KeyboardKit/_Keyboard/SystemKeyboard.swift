//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This keyboard can be used to create alphabetic, numeric and
 symbolic keyboards that mimic the native iOS keyboard.
 
 KeyboardKit will by default use a standard ``SystemKeyboard``
 if you don't provide a custom view. So, if you just want to
 use such a standard keyboard, you don't have to do anything.
 
 If you want to customize the system keyboard, just override
 ``KeyboardInputViewController/viewWillSetupKeyboard()`` and
 call any of the `setup(with:)` functions with a custom view.
 
 For more information on how to customize this view, as well
 as code examples, see <doc:Essentials>.
 */
public struct SystemKeyboard<
    ButtonContent: View,
    ButtonView: View,
    EmojiKeyboard: View,
    Toolbar: View>: View {
    
    /**
     Create a system keyboard based on state and services.
     
     - Parameters:
       - state: The value to fetch observable state from.
       - services: The value to fetch keyboard services from.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonContent: The content view to use for buttons.
       - buttonView: The button view to use for an buttons.
       - emojiKeyboard: The emoji keyboard to use for an ``Keyboard/KeyboardType/emojis`` keyboard.
       - toolbar: The toolbar view to add above the keyboard.
     */
    public init(
        state: Keyboard.KeyboardState,
        services: Keyboard.KeyboardServices,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        self.init(
            layout: services.layoutProvider.keyboardLayout(for: state.keyboardContext),
            actionHandler: services.actionHandler,
            styleProvider: services.styleProvider,
            keyboardContext: state.keyboardContext,
            autocompleteContext: state.autocompleteContext,
            calloutContext: state.calloutContext,
            renderBackground: renderBackground,
            buttonContent: buttonContent,
            buttonView: buttonView,
            emojiKeyboard: emojiKeyboard,
            toolbar: toolbar
        )
    }
    
    /**
     Create a system keyboard based on raw properties.
     
     - Parameters:
       - layout: The layout to use.
       - actionHandler: The action handler to use.
       - styleProvider: The style provider to use.
       - keyboardContext: The keyboard context to use.
       - autocompleteContext: The autocomplete context to use.
       - calloutContext: The callout context to use.
       - renderBackground: Whether or not to render the background, by default `true`.
       - buttonContent: The content view to use for buttons.
       - buttonView: The button view to use for an buttons.
       - emojiKeyboard: The emoji keyboard to use for an ``Keyboard/KeyboardType/emojis`` keyboard.
       - toolbar: The toolbar view to add above the keyboard.
     */
    public init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        styleProvider: KeyboardStyleProvider,
        keyboardContext: KeyboardContext,
        autocompleteContext: AutocompleteContext,
        calloutContext: CalloutContext?,
        renderBackground: Bool = true,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        if !Emoji.KeyboardWrapper.isPro {
            layout.itemRows.remove(.keyboardType(.emojis))
        }
        self.layout = layout
        self.layoutConfig = .standard(for: keyboardContext)
        self.actionHandler = actionHandler
        self.styleProvider = styleProvider
        self.renderBackground = renderBackground
        self.buttonContentBuilder = buttonContent
        self.buttonViewBuilder = buttonView
        self.emojiKeyboardBuilder = emojiKeyboard
        self.toolbarBuilder = toolbar
        _autocompleteContext = ObservedObject(wrappedValue: autocompleteContext)
        _calloutContext = ObservedObject(wrappedValue: calloutContext ?? .disabled)
        _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
    }


    /// This typealias defines a button content builder.
    public typealias ButtonContentBuilder = (ButtonContentParams) -> ButtonContent
    
    /// This typealias defines button content builder params.
    public typealias ButtonContentParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonContent)
    
    /// The standard button content view type.
    public typealias StandardButtonContent = KeyboardButton.Content
    
    
    /// This typealias defines a button view builder.
    public typealias ButtonViewBuilder = (ButtonViewParams) -> ButtonView
    
    /// This typealias defines button view builder params.
    public typealias ButtonViewParams = (
        item: KeyboardLayout.Item,
        view: StandardButtonView)
    
    /// The standard button view type.
    public typealias StandardButtonView = SystemKeyboardItem<ButtonContent>
    
    
    /// This typealias defines a emoji keyboard builder.
    public typealias EmojiKeyboardBuilder = (EmojiKeyboardParams) -> EmojiKeyboard
    
    /// This typealias defines emoji keyboard builder params.
    public typealias EmojiKeyboardParams = (
        style: KeyboardStyle.EmojiKeyboard,
        view: StandardEmojiKeyboard)
    
    /// The standard emoji keyboard view type.
    public typealias StandardEmojiKeyboard = Emoji.KeyboardWrapper
    

    /// This typealias defines a toolbar builder.
    public typealias ToolbarBuilder = (ToolbarParams) -> Toolbar

    /// This typealias defines toolbar builder params.
    public typealias ToolbarParams = (
        autocompleteAction: (Autocomplete.Suggestion) -> Void,
        style: Autocomplete.ToolbarStyle,
        view: StandardToolbarView)

    /// The standard toolbar view type.
    public typealias StandardToolbarView = Autocomplete.Toolbar<Autocomplete.ToolbarItem, Autocomplete.ToolbarSeparator>

    
    private let actionHandler: KeyboardActionHandler
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayout.Configuration
    private let styleProvider: KeyboardStyleProvider
    private let renderBackground: Bool
    
    private let buttonContentBuilder: ButtonContentBuilder
    private let buttonViewBuilder: ButtonViewBuilder
    private let emojiKeyboardBuilder: EmojiKeyboardBuilder
    private let toolbarBuilder: ToolbarBuilder

    public typealias AutocompleteToolbarAction = (Autocomplete.Suggestion) -> Void
    
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
        StandardKeyboardStyleProvider.iPadProRenderingModeActive = layout.ipadProLayout
        return geoContent
            .autocorrectionDisabled(with: autocompleteContext)
            .opacity(shouldShowEmojiKeyboard ? 0 : 1)
            .overlay(emojiKeyboard(), alignment: .bottom)
            .foregroundColor(styleProvider.foregroundColor)
            .background(renderBackground ? styleProvider.backgroundStyle : nil)
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
    
    var geoContent: some View {
        bodyContent(
            for: .init(width: 100, height: 0)
        )
        .disabled(true)
        .opacity(0)
        .overlay(GeometryReader(content: bodyContent))
    }
    
    func bodyContent(for geo: GeometryProxy) -> some View {
        bodyContent(for: geo.size)
    }
    
    func bodyContent(for size: CGSize) -> some View {
        VStack(spacing: 0) {
            toolbar()
            systemKeyboard(for: size)
        }
    }

    func systemKeyboard(for size: CGSize) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(layout.itemRows.enumerated()), id: \.offset) {
                items(for: size, layout: layout, itemRow: $0.element)
            }
        }
        .padding(styleProvider.keyboardEdgeInsets)
        .environment(\.layoutDirection, .leftToRight)
    }
    
    func items(
        for size: CGSize,
        layout: KeyboardLayout,
        itemRow: KeyboardLayout.ItemRow
    ) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(itemRow.enumerated()), id: \.offset) {
                buttonView(
                    for: $0.element,
                    totalWidth: size.width
                )
            }
            .id(keyboardContext.locale.identifier)
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
        for item: KeyboardLayout.Item,
        totalWidth width: CGFloat
    ) -> ButtonView {
        buttonViewBuilder((
            item: item,
            view: SystemKeyboardItem(
                item: item,
                actionHandler: actionHandler,
                styleProvider: styleProvider,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                keyboardWidth: width,
                inputWidth: layout.inputWidth(for: width),
                content: buttonContent(for: item)
            )
        ))
    }
    
    func emojiKeyboard() -> some View {
        emojiKeyboardBuilder((
            style: KeyboardStyle.EmojiKeyboard.standard(for: keyboardContext),
            view: Emoji.KeyboardWrapper(
                actionHandler: actionHandler,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                styleProvider: styleProvider
            )
        ))
        .opacity(shouldShowEmojiKeyboard ? 1 : 0)
    }
    
    func toolbar() -> some View {
        toolbarBuilder((
            autocompleteAction: actionHandler.handle(_:),
            style: styleProvider.autocompleteToolbarStyle,
            view: Autocomplete.Toolbar(
                suggestions: autocompleteContext.suggestions,
                locale: keyboardContext.locale,
                style: styleProvider.autocompleteToolbarStyle,
                suggestionAction: actionHandler.handle(_:)
            )
        ))
        .frame(minHeight: styleProvider.autocompleteToolbarStyle.height)
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
            controller.state.autocompleteContext.suggestions = [
                .init(text: "Foo"),
                .init(text: "Bar", isAutocorrect: true),
                .init(text: "Baz")
            ]
            // controller.keyboardContext.keyboardType = .emojis
            return controller
        }()
        
        var emojiKeyboard: some View {
            Button {
                controller.state.keyboardContext.keyboardType = .alphabetic(.lowercased)
            } label: {
                Color.red
                    .overlay(Text("Not implemented"))
            }
        }
        
        var keyboard: some View {
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }

        var body: some View {
            VStack(spacing: 10) {
                Group {
                    ZStack {
                        keyboard.offset(x: -200)
                        keyboard.offset(x: 200)
                    }
                    
                    keyboard.frame(width: 250)
                    
                    SystemKeyboard(
                        state: controller.state,
                        services: controller.services,
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
                            emojiKeyboard
                        },
                        toolbar: { $0.view }
                    )
                }.background(Color.keyboardBackground)
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
