//
//  KeyboardView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view can be used to mimic a native iOS keyboard.
///
/// This view can render any ``KeyboardLayout`` and supports
/// alphabetic, numeric and symbolic keyboard types, as well
/// as any custom layout you may specify.
///
/// KeyboardKit will by default use this as the default view.
/// So, if you only want to use a standard keyboard view and
/// use the ``KeyboardInputViewController/state`` properties
/// and the ``KeyboardInputViewController/services`` service
/// instances to customize it, you don't have to do anything.
///
/// See the <doc:Essentials-KeyboardView> article for a very
/// important discussion on how to configure this view, with
/// both optional environment values and the various context
/// and settings types. Note that this is still a transition
/// in progress, which is why there are discrepancies in how
/// the view uses environment values, contexts, and settings
public struct KeyboardView<
    ButtonContent: View,
    ButtonView: View,
    CollapsedView: View,
    EmojiKeyboard: View,
    Toolbar: View>: KeyboardViewComponent {

    /// Create a keyboard based on state and services.
    ///
    /// - Parameters:
    ///   - layout: A custom keyboard layout, if any.
    ///   - state: The keyboard state to use.
    ///   - services: The keyboard services to use.
    ///   - renderBackground: Whether to render the style background.
    ///   - buttonContent: The content view to use for buttons.
    ///   - buttonView: The button view to use for an buttons.
    ///   - collapsedView: The collapsed view to use.
    ///   - emojiKeyboard: The emoji keyboard to use.
    ///   - toolbar: The toolbar view to add above the keyboard.
    public init(
        layout: KeyboardLayout? = nil,
        state: Keyboard.State,
        services: Keyboard.Services,
        renderBackground: Bool? = nil,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder collapsedView: @escaping CollapsedViewBuilder,
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
            collapsedView: collapsedView,
            emojiKeyboard: emojiKeyboard,
            toolbar: toolbar
        )
    }

    /// Create a keyboard based on raw properties.
    ///
    /// - Parameters:
    ///   - layout: The layout to use.
    ///   - actionHandler: The action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - styleService: The style service to use.
    ///   - keyboardContext: The keyboard context to use.
    ///   - autocompleteContext: The autocomplete context to use.
    ///   - calloutContext: The callout context to use.
    ///   - renderBackground: Whether to render the style background.
    ///   - buttonContent: The content view to use for buttons.
    ///   - buttonView: The button view to use for an buttons.
    ///   - collapsedView: The collapsed view to use.
    ///   - emojiKeyboard: The emoji keyboard to use for an ``Keyboard/KeyboardType/emojis`` keyboard.
    ///   - toolbar: The toolbar view to add above the keyboard.
    public init(
        layout: KeyboardLayout,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        styleService: KeyboardStyleService,
        keyboardContext: KeyboardContext,
        autocompleteContext: AutocompleteContext,
        calloutContext: KeyboardCalloutContext,
        renderBackground: Bool? = nil,
        @ViewBuilder buttonContent: @escaping ButtonContentBuilder,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder,
        @ViewBuilder collapsedView: @escaping CollapsedViewBuilder,
        @ViewBuilder emojiKeyboard: @escaping EmojiKeyboardBuilder,
        @ViewBuilder toolbar: @escaping ToolbarBuilder
    ) {
        var layout = layout
        let layoutConfig = KeyboardLayout.DeviceConfiguration.standard(for: keyboardContext)
        
        let hasProEmojiKeyboard = !Emoji.KeyboardWrapper.isEmptyPlaceholder
        let hasCustomEmojiKeyboard = EmojiKeyboard.self != Emoji.KeyboardWrapper.self
        let hasEmojiKeyboard = hasProEmojiKeyboard || hasCustomEmojiKeyboard
        if !hasEmojiKeyboard {
            layout.itemRows.remove(.keyboardType(.emojis))
        }
        
        self.rawLayout = layout
        self.layoutConfig = layoutConfig
        self.actionHandler = actionHandler
        self.repeatTimer = repeatTimer
        self.styleService = styleService
        self.renderBackground = renderBackground ?? true
        self.buttonContentBuilder = buttonContent
        self.buttonViewBuilder = buttonView
        self.collapsedViewBuilder = collapsedView
        self.emojiKeyboardBuilder = emojiKeyboard
        self.toolbarBuilder = toolbar

        _autocompleteContext = .init(wrappedValue: autocompleteContext)
        _calloutContext = .init(wrappedValue: calloutContext)
        _keyboardContext = .init(wrappedValue: keyboardContext)
    }

    private let actionHandler: KeyboardActionHandler
    private let repeatTimer: GestureButtonTimer?
    private let rawLayout: KeyboardLayout
    private let layoutConfig: KeyboardLayout.DeviceConfiguration
    private let styleService: KeyboardStyleService
    private let renderBackground: Bool

    private let buttonContentBuilder: ButtonContentBuilder
    private let buttonViewBuilder: ButtonViewBuilder
    private let collapsedViewBuilder: CollapsedViewBuilder
    private let emojiKeyboardBuilder: EmojiKeyboardBuilder
    private let toolbarBuilder: ToolbarBuilder

    private var calloutStyle: KeyboardCallout.CalloutStyle {
        var style = styleService.calloutStyle ?? calloutStyleFromEnvironment
        let insets = layoutConfig.buttonInsets
        style.buttonOverlayInset = .init(width: insets.leading, height: insets.top)
        return style
    }
    
    @Environment(\.emojiKeyboardStyle) var emojiKeyboardStyleFromEnvironment
    @Environment(\.keyboardCalloutStyle) var calloutStyleFromEnvironment
    @Environment(\.keyboardDockEdge) var dockEdgeFromEnvironment
    @Environment(\.keyboardInputToolbarDisplayMode) var inputToolbarDisplayModeFromEnvironment
    
    @ObservedObject var autocompleteContext: AutocompleteContext
    @ObservedObject var calloutContext: KeyboardCalloutContext
    @ObservedObject var keyboardContext: KeyboardContext

    public var body: some View {
        if keyboardContext.isKeyboardCollapsed {
            collapsedContent
                .transition(.move(edge: .bottom))
        } else {
            keyboardContent
                .transition(.move(edge: .bottom))
        }
    }

    var collapsedContent: some View {
        collapsedViewBuilder((
            binding: $keyboardContext.isKeyboardCollapsed,
            view: Keyboard.CollapsedView(openKeyboardAction: {
                keyboardContext.isKeyboardCollapsed.toggle()
            }, content: {
                EmptyView()
            })
        ))
    }

    var keyboardContent: some View {
        KeyboardStyle.StandardStyleService.iPadProRenderingModeActive = layout.isIpadProLayout

        return VStack(spacing: 0) {
            toolbar
            keyboardView
        }
        .autocorrectionDisabled(with: autocompleteContext)
        .opacity(shouldShowKeyboard ? 1 : 0)
        .overlay(emojiKeyboard, alignment: .bottom)
        .overlay(numberPad, alignment: .bottom)
        .foregroundColor(styleService.foregroundColor)
        .background(renderBackground ? styleService.backgroundStyle : nil)
        .keyboardCalloutContainer(
            calloutContext: calloutContext,
            keyboardContext: keyboardContext
        )
        .keyboardCalloutStyle(calloutStyle)
        .keyboardDockEdge(keyboardContext.settings.keyboardDockEdge)
        .keyboardInputToolbarDisplayMode(inputToolbarDisplayMode)
    }
}


// MARK: - Properties

private extension KeyboardView {
    
    var dockEdge: Keyboard.DockEdge? {
        dockEdgeFromEnvironment ?? keyboardContext.settings.keyboardDockEdge
    }

    var isLargePad: Bool {
        let size = keyboardContext.screenSize
        return size.isScreenSize(.iPadProLargeScreenPortrait, withTolerance: 50)
    }

    var inputToolbarDisplayMode: Keyboard.InputToolbarDisplayMode {
        let value = inputToolbarDisplayModeFromEnvironment ?? keyboardContext.settings.inputToolbarDisplayMode
        switch value {
        case .automatic: return isLargePad ? .numbers : .none
        default: return value
        }
    }
    
    var keyboardAlignment: Alignment {
        dockEdge?.alignment ?? .center
    }

    var layout: KeyboardLayout {
        rawLayout.adjusted(
            for: inputToolbarDisplayMode,
            layoutConfiguration: layoutConfig
        )
    }

    var shouldShowKeyboard: Bool {
        switch keyboardContext.keyboardType {
        case .emojis: false
        case .numberPad: false
        default: true
        }
    }

    var shouldShowEmojiKeyboard: Bool {
        switch keyboardContext.keyboardType {
        case .emojis: true
        case .emojiSearch: true
        default: false
        }
    }

    var shouldShowToolbar: Bool {
        switch keyboardContext.keyboardType {
        case .emojiSearch: false
        default: true
        }
    }
}


// MARK: - Typealiases

public extension KeyboardView {

    /// This typealias defines a collapsed view builder.
    typealias CollapsedViewBuilder = (CollapsedViewParams) -> CollapsedView

    /// This struct defines collapsed view builder params.
    typealias CollapsedViewParams = (
        binding: Binding<Bool>,
        view: StandardCollapsedView)

    /// The standard collapsed view.
    typealias StandardCollapsedView = Keyboard.CollapsedView<EmptyView>


    /// This typealias defines an emoji keyboard builder.
    typealias EmojiKeyboardBuilder = (EmojiKeyboardParams) -> EmojiKeyboard

    /// This typealias defines emoji keyboard builder params.
    typealias EmojiKeyboardParams = (
        style: Emoji.KeyboardStyle,
        view: StandardEmojiKeyboard)

    /// The standard emoji keyboard view.
    typealias StandardEmojiKeyboard = Emoji.KeyboardWrapper


    /// This typealias defines a toolbar builder.
    typealias ToolbarBuilder = (ToolbarParams) -> Toolbar

    /// This typealias defines toolbar builder params.
    typealias ToolbarParams = (
        autocompleteAction: (Autocomplete.Suggestion) -> Void,
        style: Autocomplete.ToolbarStyle,
        view: StandardToolbar)

    /// The standard toolbar view.
    typealias StandardToolbar = Autocomplete.Toolbar<Autocomplete.ToolbarItem, Autocomplete.ToolbarSeparator>
}


// MARK: - Views

private extension KeyboardView {

    var keyboardView: some View {
        GeometryReader { geo in
            let keyboardWidth = keyboardWidth(for: geo.size.width)
            let inputWidth = layout.inputWidth(for: keyboardWidth)
            VStack {
                VStack(spacing: 0) {
                    ForEach(Array(layout.itemRows.enumerated()), id: \.offset) { row in
                        HStack(spacing: 0) {
                            ForEach(Array(row.element.enumerated()), id: \.offset) { item in
                                buttonView(
                                    for: item.element,
                                    totalWidth: keyboardWidth,
                                    inputWidth: inputWidth,
                                    isGestureAutoCancellable: row.offset == 0
                                )
                            }
                        }
                    }
                }
                .padding(styleService.keyboardEdgeInsets)
                .environment(\.layoutDirection, .leftToRight)   // Enforce a layout direction
                .frame(width: keyboardWidth)
            }
            .frame(maxWidth: .infinity, alignment: keyboardAlignment)
        }
        .frame(height: layout.totalHeight)
    }
    
    func keyboardWidth(for totalWidth: Double) -> Double {
        let isDocked = dockEdge != nil
        return isDocked ? 0.8 * totalWidth : totalWidth
    }

    @ViewBuilder
    var emojiKeyboard: some View {
        emojiKeyboardContent
            .emojiKeyboardStyle(emojiKeyboardStyle)
            .id(keyboardContext.interfaceOrientation)       // TODO: Temp orientation fix, still needed?
    }

    @ViewBuilder
    var emojiKeyboardContent: some View {
        if shouldShowEmojiKeyboard {                        // Conditional to avoid allocating memory
            emojiKeyboardBuilder((
                style: emojiKeyboardStyle,
                view: Emoji.KeyboardWrapper(
                    actionHandler: actionHandler,
                    keyboardContext: keyboardContext,
                    calloutContext: calloutContext,
                    styleService: styleService
                )
            ))
        } else {
            Color.clear
        }
    }
    
    var emojiKeyboardStyle: Emoji.KeyboardStyle {
        emojiKeyboardStyleFromEnvironment(keyboardContext)
            .augmented(for: inputToolbarDisplayMode)
    }

    @ViewBuilder
    var numberPad: some View {
        if keyboardContext.keyboardType == .numberPad {
            Keyboard.NumberPad(
                actionHandler: actionHandler,
                styleService: styleService,
                keyboardContext: keyboardContext
            )
            .padding(10)
        }
    }

    var toolbar: some View {
        let style = styleService.autocompleteToolbarStyle
        return ZStack {
            toolbarEmojiHeight(for: style)
            toolbarBuilder((
                autocompleteAction: actionHandler.handle(_:),
                style: styleService.autocompleteToolbarStyle,
                view: Autocomplete.Toolbar(
                    suggestions: autocompleteContext.suggestions,
                    itemView: { $0.view },
                    separatorView: { $0.view },
                    suggestionAction: actionHandler.handle(_:)
                )
            ))
            .autocompleteToolbarStyle(style)
            .frame(minHeight: style.height)
        }
        .opacity(shouldShowToolbar ? 1 : 0)
    }

    @ViewBuilder
    func toolbarEmojiHeight(
        for style: Autocomplete.ToolbarStyle
    ) -> some View {
        if toolbarNeedsEmojiHeight {
            Color.clear.frame(height: style.height)
        }
    }

    var toolbarNeedsEmojiHeight: Bool {
        switch keyboardContext.keyboardType {
        case .emojis, .emojiSearch: true
        default: false
        }
    }
}

private extension KeyboardView {

    func buttonContent(
        for item: KeyboardLayout.Item
    ) -> ButtonContent {
        buttonContentBuilder((
            item: item,
            view: Keyboard.ButtonContent(
                action: item.action,
                styleService: styleService,
                keyboardContext: keyboardContext
            )
        ))
    }

    func buttonView(
        for item: KeyboardLayout.Item,
        totalWidth width: Double,
        inputWidth: Double,
        isGestureAutoCancellable: Bool
    ) -> ButtonView {
        let action = item.action
        let prediction = autocompleteContext.nextCharacterPrediction(for: action)
        return buttonViewBuilder((
            item: item,
            view: KeyboardViewItem(
                item: item,
                actionHandler: actionHandler,
                repeatTimer: repeatTimer,
                styleService: styleService,
                keyboardContext: keyboardContext,
                calloutContext: calloutContext,
                keyboardWidth: width,
                inputWidth: inputWidth,
                isNextProbability: prediction,
                isGestureAutoCancellable: isGestureAutoCancellable,
                content: buttonContent(for: item)
            )
        ))
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
#Preview {
    
    class PreviewLayoutService: KeyboardLayout.StandardLayoutService {
        
        override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
            var layout = super.keyboardLayout(for: context)
            var item = layout.createIdealItem(for: .nextLocale)
            item.size.width = .inputPercentage(1.3)
            layout.itemRows.insert(item, before: .primary(.return))
            return layout
        }
    }

    struct Preview: View {

        var controller: KeyboardInputViewController = {
            let controller = KeyboardInputViewController.preview
            
            let context = controller.state.keyboardContext
            context.locale = .english
            context.settings.addedLocales = [.english, .swedish, .persian].map { .init($0) } 
            context.settings.keyboardDockEdge = .none
//            context.settings.spaceLongPressBehavior = .moveInputCursorWithLocaleSwitcher
            
            controller.state.autocompleteContext.suggestionsFromService = [
                .init(text: "Foo"),
                .init(text: "Bar", type: .autocorrect),
                .init(text: "Baz")
            ]
            // controller.services.layoutService = PreviewLayoutService()
            // controller.services.styleService = .crazy
            // controller.state.keyboardContext.keyboardType = .emojiSearch
            return controller
        }()
        
        var keyboardContext: KeyboardContext {
            controller.state.keyboardContext
        }
        
        @Environment(\.colorScheme) var colorScheme
        
        @State var dockEdge: Keyboard.DockEdge?
        
        var body: some View {
            VStack {
                Spacer()
                KeyboardView(
                    state: controller.state,
                    services: controller.services,
                    renderBackground: true,
                    buttonContent: { $0.view },
                    buttonView: { $0.view },
                    collapsedView: { $0.view },
                    emojiKeyboard: { $0.view },
                    toolbar: { $0.view }
                )
                .padding(.bottom, 15)
                .background(Color.keyboardBackground)
            }
            
//            KeyboardView(
//                state: controller.state,
//                services: controller.services,
//                buttonContent: { param in
//                    switch param.item.action {
//                    case .backspace:
//                        Image(systemName: "trash").foregroundColor(Color.red)
//                    default: param.view
//                    }
//                },
//                buttonView: { param in
//                    switch param.item.action {
//                    case .space:
//                        Text("This is a space bar replacement")
//                            .frame(maxWidth: .infinity)
//                            .multilineTextAlignment(.center)
//                    default: param.view
//                    }
//                },
//                collapsedView: { _ in
//                    Color.red.frame(height: 100)
//                },
//                emojiKeyboard: { _ in
//                    Button {
//                        controller.state.keyboardContext.keyboardType = .alphabetic
//                    } label: {
//                        Color.orange
//                            .overlay(Text("Not implemented"))
//                    }
//                },
//                toolbar: { $0.view }
//            )
//            .keyboardDockEdge(dockEdge)
        }
    }

    return Preview()
}
#endif
