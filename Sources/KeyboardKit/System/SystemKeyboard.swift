//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI

/**
 This view renders a system keyboard, which aims to mimic an
 iOS keyboard as closely as possible.

 This view can be used for keyboard like standard alphabetic,
 numeric and symbolic keyboards, as well as emoji ones if it
 is used on iOS 14 and later.

 There are several ways to create a system keyboard. Use the
 initializer without a view builder to use a standard button
 for each action. Use the `buttonContent` initializer to use
 custom content for some or all buttons, but with a standard
 shape, color, shadows etc. Use the `buttonView` initializer
 to use entirely custom views for some or all button. If you
 want to use standard content or views for some buttons, use
 `standardButtonContent` and `standardButtonView`.

 Since the keyboard depends on the available width, you must
 provide a `width`. If you don't provide one, this view will
 use the ``standardKeyboardWidth`` which uses the width from
 the shared input view controller's view.

 The initializers may look strange, since the default values
 for `controller` and `width` are `nil` then resolved in the
 initializer. The is because there's an Xcode bug that makes
 the default parameters fail to compile when they're part of
 a binary framework. Instead, using `nil` and then resolving
 the values in the initializer body works.
 */
public struct SystemKeyboard<ButtonView: View>: View {

    /**
     Create a system keyboard that uses a custom `buttonView`
     builder to create the entire view for every layout item.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat? = nil,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        let width = width ?? Self.standardKeyboardWidth
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

    /**
     Create a system keyboard view that uses a standard view
     builder for every layout item.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat? = nil
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
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

    /**
     Create a system keyboard view, that uses `buttonContent`
     to customize the intrinsic content of every layout item.
     */
    public init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        actionCalloutContext: ActionCalloutContext?,
        inputCalloutContext: InputCalloutContext?,
        width: CGFloat? = nil,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
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
                    content: buttonContent(item),
                    item: item,
                    keyboardContext: keyboardContext,
                    keyboardWidth: keyboardWidth,
                    inputWidth: inputWidth,
                    appearance: appearance,
                    actionHandler: actionHandler
                )
            }
        )
    }

    /**
     Create a system keyboard view that uses a standard view
     builder for every layout item.
     */
    public init(
        controller: KeyboardInputViewController? = nil,
        width: CGFloat? = nil
    ) where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
        let controller = controller ?? .shared
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width
        )
    }

    /**
     Create a system keyboard that uses a custom `buttonView`
     builder to create the entire view for every layout item.
     */
    public init(
        controller: KeyboardInputViewController? = nil,
        width: CGFloat? = nil,
        @ViewBuilder buttonView: @escaping ButtonViewBuilder
    ) {
        let controller = controller ?? .shared
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width,
            buttonView: buttonView
        )
    }

    /**
     Create a system keyboard view, that uses `buttonContent`
     to customize the intrinsic content of every layout item.
     */
    public init<ButtonContentView: View>(
        controller: KeyboardInputViewController? = nil,
        width: CGFloat? = nil,
        @ViewBuilder buttonContent: @escaping (KeyboardLayoutItem) -> ButtonContentView
    ) where ButtonView == SystemKeyboardButtonRowItem<ButtonContentView> {
        let controller = controller ?? .shared
        self.init(
            layout: controller.keyboardLayoutProvider.keyboardLayout(for: controller.keyboardContext),
            appearance: controller.keyboardAppearance,
            actionHandler: controller.keyboardActionHandler,
            keyboardContext: controller.keyboardContext,
            actionCalloutContext: controller.actionCalloutContext,
            inputCalloutContext: controller.inputCalloutContext,
            width: width,
            buttonContent: buttonContent
        )
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

    @ObservedObject
    private var actionCalloutContext: ActionCalloutContext

    @ObservedObject
    private var inputCalloutContext: InputCalloutContext

    @ObservedObject
    private var keyboardContext: KeyboardContext

    public var body: some View {
        keyboardView
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
    var keyboardView: some View {
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
     The standard ``SystemKeyboardActionButtonContent`` view
     that will be used as intrinsic content for every layout
     item in the keyboard if you don't use a `buttonView` or
     `buttonContent` initializer.
     */
    static func standardButtonContent(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        keyboardContext: KeyboardContext
    ) -> SystemKeyboardActionButtonContent {
        SystemKeyboardActionButtonContent(
            action: item.action,
            appearance: appearance,
            keyboardContext: keyboardContext)
    }

    /**
     The standard ``SystemKeyboardButtonRowItem`` view, that
     will be used as view for every layout item if you don't
     use the `buttonView` initializer.
     */
    static func standardButtonView(
        item: KeyboardLayoutItem,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        keyboardContext: KeyboardContext,
        keyboardWidth: KeyboardWidth,
        inputWidth: KeyboardItemWidth
    ) -> SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
        SystemKeyboardButtonRowItem(
            content: standardButtonContent(
                item: item,
                appearance: appearance,
                keyboardContext: keyboardContext),
            item: item,
            keyboardContext: keyboardContext,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: appearance,
            actionHandler: actionHandler
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

    @available(iOS 14.0, tvOS 14.0, *)
    var emojiKeyboard: some View {
        EmojiCategoryKeyboard(
            appearance: appearance,
            keyboardContext: keyboardContext,
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
                keyboardContext: .preview,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                appearance: .preview,
                actionHandler: .preview)
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
            SystemKeyboardActionButtonContent(
                action: item.action,
                appearance: .preview,
                keyboardContext: .preview
            )
        }
    }

    static var previews: some View {
        VStack {

            // A standard system keyboard
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width)


            // A keyboard that replaces the button content
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonContent: previewButtonContent)

            // A keyboard that replaces entire button views
            SystemKeyboard(
                layout: .preview,
                appearance: .preview,
                actionHandler: .preview,
                keyboardContext: .preview,
                actionCalloutContext: nil,
                inputCalloutContext: nil,
                width: UIScreen.main.bounds.width,
                buttonView: previewButton)
        }.background(Color.yellow)
    }
}
#endif
