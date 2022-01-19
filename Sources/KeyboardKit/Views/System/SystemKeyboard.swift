//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import SwiftUI

/**
 This view mimics native iOS system keyboards, like standard
 alphabetic, numeric and symbolic system keyboards.
 
 There are three ways to create a system keyboard:
 
 The first option is to use the builder-less initializer, to
 create a standard system keyboard with standard buttons.
 
 The second option is to use the `buttonContent` initializer,
 to create a system keyboard that can customize the internal
 content of each button, but doesn't affect the button shape.
 
 The third option is to use the `buttonView` initializer, to
 create a system keyboard that can customize the entire view
 for each button, including the button shape.
 
 The keyboard will automatically replace the system keyboard
 view with an ``EmojiCategoryKeyboard`` for iOS 14 and later
 if the context's keyboard type is ``KeyboardType/emojis``.
 
 Since the widths of the keyboard buttons will depend on the
 total keyboard width, the view must be given a `width` when
 it's created. If you don't provide a width, it will use the
 static `standardKeyboardWidth`, which uses the width of the
 shared input view controller's view.
 
 `IMPORTANT` In previews, you must provide a custom width to
 get buttons to show up, since there is no shared controller.
 */
public struct SystemKeyboard<ButtonView: View>: View {

    /**
     Create a system keyboard that uses a custom `buttonView`
     to generate the entire button view for each layout item.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder) {
        self.layout = layout
        self.layoutConfig = .standard(for: keyboardContext)
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.keyboardWidth = width
        self.buttonView = buttonView
        self.inputWidth = layout.inputWidth(for: width)
        _keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        _actionCalloutContext = ObservedObject(wrappedValue: actionCalloutContext ?? .disabled)
        _inputCalloutContext = ObservedObject(wrappedValue: inputCalloutContext ?? .disabled)
    }

    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonView: ButtonViewBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayoutConfiguration
    
    public typealias ButtonViewBuilder = (KeyboardLayoutItem, KeyboardWidth, KeyboardItemWidth) -> ButtonView
    public typealias KeyboardWidth = CGFloat
    public typealias KeyboardItemWidth = CGFloat
    
    private var actionCalloutStyle: ActionCalloutStyle {
        var style = appearance.actionCalloutStyle()
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    private var inputCalloutStyle: InputCalloutStyle {
        var style = appearance.inputCalloutStyle()
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }
    
    @ObservedObject private var actionCalloutContext: ActionCalloutContext
    @ObservedObject private var inputCalloutContext: InputCalloutContext
    @ObservedObject private var keyboardContext: KeyboardContext

    public var body: some View {
        if #available(iOS 14.0, tvOS 14.0, *) {
            switch keyboardContext.keyboardType {
            case .emojis: emojiKeyboard
            default: systemKeyboard
            }
        } else {
            systemKeyboard
        }
    }
}

public extension SystemKeyboard {
    
    /**
     The standard view to use as button content.
     */
    static func standardButtonContent(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext) -> SystemKeyboardActionButtonContent {
        SystemKeyboardActionButtonContent(
            action: item.action,
            appearance: appearance,
            context: keyboardContext)
    }
    
    /**
     The standard view to use as button view.
     */
    static func standardButtonView(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        keyboardWidth: KeyboardWidth,
        inputWidth: KeyboardItemWidth) -> SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
        SystemKeyboardButtonRowItem(
            content: standardButtonContent(
                item: item,
                appearance: appearance,
                keyboardContext: keyboardContext),
            item: item,
            context: keyboardContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: appearance,
            actionHandler: actionHandler
        )
    }
}

private extension SystemKeyboard {
    
    @available(iOS 14.0, tvOS 14.0, *)
    var emojiKeyboard: some View {
        EmojiCategoryKeyboard(
            appearance: appearance,
            context: keyboardContext,
            style: .standard(for: keyboardContext))
            .padding(.top)
    }
    
    var systemKeyboard: some View {
        VStack(spacing: 0) {
            itemRows(for: layout)
        }
        .actionCallout(
            context: actionCalloutContext,
            style: actionCalloutStyle)
        .inputCallout(
            context: inputCalloutContext,
            keyboardContext: keyboardContext,
            style: inputCalloutStyle)
        .environment(\.layoutDirection, .leftToRight)
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<AnyView> {
    
    /**
     Create a keyboard that uses a custom `buttonContent` to
     customize the content of each button.
     */
    init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            actionCalloutContext: actionCalloutContext,
            inputCalloutContext: inputCalloutContext,
            width: width,
            buttonView: { item, keyboardWidth, inputWidth in
                SystemKeyboardButtonRowItem(
                    content: AnyView(buttonContent(item)),
                    item: item,
                    context: keyboardContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth,
                    appearance: appearance,
                    actionHandler: actionHandler
                )
            }
        )
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
    
    /**
     Create a system keyboard that creates a standard system
     keyboard, with standard button views.
     */
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat = standardKeyboardWidth) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            keyboardContext: keyboardContext,
            actionCalloutContext: actionCalloutContext,
            inputCalloutContext: inputCalloutContext,
            width: width,
            buttonView: { item, keyboardWidth, inputWidth in
                Self.standardButtonView(
                    item: item,
                    appearance: appearance,
                    actionHandler: actionHandler,
                    keyboardContext: keyboardContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth)
            }
        )
    }
}

public extension SystemKeyboard {
    
    /**
     This is the standard keyboard width, which is retrieved
     from ``KeyboardInputViewController/shared``.
     */
    static var standardKeyboardWidth: CGFloat {
        KeyboardInputViewController.shared.view.frame.width
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
            }
        }
    }
}

struct SystemKeyboard_Previews: PreviewProvider {
    
    static let actionHandler = PreviewKeyboardActionHandler()

    @ViewBuilder
    static func previewButton(
        item: KeyboardLayoutItem,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat) -> some View {
        switch item.action {
        case .space:
            Text("This is a space bar replacement")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
        default:
            StandardSystemKeyboardButtonView(
                content: previewButtonContent(item: item),
                item: item,
                context: .preview,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                appearance: .preview,
                actionHandler: actionHandler)
        }
    }

    @ViewBuilder
    static func previewButtonContent(
        item: KeyboardLayoutItem) -> some View {
        switch item.action {
        case .backspace:
            Text("<-").foregroundColor(Color.red)
        default:
            StandardSystemKeyboardButtonContent(
                action: item.action,
                appearance: PreviewKeyboardAppearance(),
                context: .preview
            )
        }
    }
    
    static var previews: some View {
        VStack {
            
            // A standard system keyboard
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width)
            
            
            // A keyboard that replaces the button content
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonContent: previewButtonContent)
            
            // A keyboard that replaces entire button views
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonView: previewButton)
        }.background(Color.yellow)
    }
}
#endif
