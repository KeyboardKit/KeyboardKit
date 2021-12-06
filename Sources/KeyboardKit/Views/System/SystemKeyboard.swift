//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This typealias represents the action block that is used
 to create button views for the system keyboard.
 */
public typealias ButtonBuilder<ItemContent> = (KeyboardAction, KeyboardAppearance, KeyboardContext) -> ItemContent

/**
 This view mimics native system keyboards, like the standard
 alphabetic, numeric and symbolic system keyboards.
 
 The keyboard view takes a `keyboardLayout` and converts the
 actions to buttons, using the provided `buttonBuilder`. The
 buttons are then wrapped in a view that applies styling and
 gestures to the provided view.
 
 Since the widths of the keyboard buttons will depend on the
 total width of the keyboard, the view must be given a fixed
 width. If you don't provide an explicit width, the width of
 the shared input view controller's view will be used.
 
 `IMPORTANT` In previews, you must provide a custom width to
 get buttons to show up, since there is no shared controller.
 */
public struct SystemKeyboard<RowItem: View>: View {

    /**
     Create an autocomplete toolbar.
     
     - Parameters:
       - layout: The keyboard layout to use in the keyboard.
       - appearance: The keyboard appearance to use in the keyboard.
       - actionHandler: The action handler to use in the keyboard.
       - width: The total width of the keyboard, used for button size calculations.
       - rowItem: ViewBuilder used to create the actual keyboard buttons
     */
    public init(
            layout: KeyboardLayout,
            appearance: KeyboardAppearance,
            actionHandler: KeyboardActionHandler,
            context: KeyboardContext,
            inputContext: InputCalloutContext?,
            secondaryInputContext: SecondaryInputCalloutContext?,
            width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
            @ViewBuilder rowItem: @escaping (KeyboardLayoutItem, CGFloat, CGFloat) -> RowItem
    ) {
        self.layout = layout
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.keyboardWidth = width
        self.rowItem = rowItem
        self.inputWidth = layout.inputWidth(for: width)
        _context = ObservedObject(wrappedValue: context)
        _inputContext = ObservedObject(wrappedValue: inputContext ?? .disabled)
        _secondaryInputContext = ObservedObject(wrappedValue: secondaryInputContext ?? .disabled)
    }

    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let rowItem: (KeyboardLayoutItem, CGFloat, CGFloat) -> RowItem
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let layout: KeyboardLayout

    private var layoutConfig: KeyboardLayoutConfiguration {
        .standard(for: context)
    }

    private var inputCalloutStyle: InputCalloutStyle {
        var style = appearance.inputCalloutStyle()
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    private var secondaryInputCalloutStyle: SecondaryInputCalloutStyle {
        var style = appearance.secondaryInputCalloutStyle()
        let insets = layoutConfig.buttonInsets
        style.callout.buttonInset = CGSize(width: insets.leading, height: insets.top)
        return style
    }

    @ObservedObject private var context: KeyboardContext
    @ObservedObject private var inputContext: InputCalloutContext
    @ObservedObject private var secondaryInputContext: SecondaryInputCalloutContext

    public var body: some View {
        VStack(spacing: 0) {
            rows(for: layout)
        }
        .inputCallout(
            context: inputContext,
            keyboardContext: context,
            style: inputCalloutStyle)
        .secondaryInputCallout(
            context: secondaryInputContext,
            style: secondaryInputCalloutStyle
        )
    }
}

public extension SystemKeyboard where RowItem == AnyView {

/**
 Convenience initializer that uses standard buttons.

 - Parameters:
   - layout: The keyboard layout to use in the keyboard.
   - appearance: The keyboard appearance to use in the keyboard.
   - actionHandler: The action handler to use in the keyboard.
   - width: The total width of the keyboard, used for button size calculations.
   - buttonBuilder: An optional, custom button builder. By default, the static `standardButton` will be used.
 */
    @available(*, deprecated, message: "Use standardSystemKeyboard() instead")
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
        buttonBuilder: @escaping ButtonBuilder<AnyView> = { action, appearance, context in
            AnyView(standardButtonBuilder(action: action, appearance: appearance, context: context))
        }) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            context: context,
            inputContext: inputContext,
            secondaryInputContext: secondaryInputContext,
            width: width,
            rowItem: { item, keyboardWidth, inputWidth in
                AnyView(
                    SystemKeyboardButtonRowItem(
                        content: buttonBuilder(item.action, appearance, context),
                        item: item,
                        context: context,
                        keyboardWidth: keyboardWidth,
                        inputWidth: inputWidth,
                        appearance: appearance,
                        actionHandler: actionHandler
                    )
                )
            }
        )
    }
}

/**
 Convenience initializer that uses standard buttons.

 - Parameters:
   - layout: The keyboard layout to use in the keyboard.
   - appearance: The keyboard appearance to use in the keyboard.
   - actionHandler: The action handler to use in the keyboard.
   - width: The total width of the keyboard, used for button size calculations.
   - buttonBuilder: An optional, custom button builder. By default, the static `standardButton` will be used.
 */
func standardSystemKeyboard(
    layout: KeyboardLayout,
    appearance: KeyboardAppearance,
    actionHandler: KeyboardActionHandler,
    context: KeyboardContext,
    inputContext: InputCalloutContext?,
    secondaryInputContext: SecondaryInputCalloutContext?,
    width: CGFloat = KeyboardInputViewController.shared.view.frame.width) -> some View {
    SystemKeyboard(
        layout: layout,
        appearance: appearance,
        actionHandler: actionHandler,
        context: context,
        inputContext: inputContext,
        secondaryInputContext: secondaryInputContext,
        width: width) { item, keyboardWidth, inputWidth in
        // Use standard button builder
        SystemKeyboardButtonRowItem(
                content: defaultButtonBuilder(action: item.action, appearance: appearance, context: context),
                item: item,
                context: context,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                appearance: appearance,
                actionHandler: actionHandler
        )
    }
}

/**
 Convenience initializer that uses standard buttons frames, but allows for customizing the button content.

 - Parameters:
   - layout: The keyboard layout to use in the keyboard.
   - appearance: The keyboard appearance to use in the keyboard.
   - actionHandler: The action handler to use in the keyboard.
   - width: The total width of the keyboard, used for button size calculations.
 */
func standardSystemKeyboard<ButtonContent: View>(
    layout: KeyboardLayout,
    appearance: KeyboardAppearance,
    actionHandler: KeyboardActionHandler,
    context: KeyboardContext,
    inputContext: InputCalloutContext?,
    secondaryInputContext: SecondaryInputCalloutContext?,
    width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
    buttonBuilder: @escaping ButtonBuilder<ButtonContent>) -> some View {
    SystemKeyboard(
        layout: layout,
        appearance: appearance,
        actionHandler: actionHandler,
        context: context,
        inputContext: inputContext,
        secondaryInputContext: secondaryInputContext,
        width: width,
        rowItem: { item, keyboardWidth, inputWidth in
            SystemKeyboardButtonRowItem(
                content: buttonBuilder(item.action, appearance, context),
                item: item,
                context: context,
                keyboardWidth: keyboardWidth,
                inputWidth: inputWidth,
                appearance: appearance,
                actionHandler: actionHandler
            )
        }
    )
}

public extension SystemKeyboard {

    /**
     This is the standard system keyboard button builder that will be used
     when no custom builder is provided to the view.
     */
    @available(*, deprecated, message: "Use defaultButtonBuilder() instead")
    static func standardButtonBuilder(
        action: KeyboardAction,
            appearance: KeyboardAppearance,
            context: KeyboardContext) -> AnyView {
        AnyView(defaultButtonBuilder(action: action, appearance: appearance, context: context))
    }

}
/**
 This is the standard `buttonBuilder`, that will be used
 when no custom builder is provided to the view.
 */
func defaultButtonBuilder(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext) -> SystemKeyboardActionButtonContent {
    SystemKeyboardActionButtonContent(
            action: action,
            appearance: appearance,
            context: context
    )
}
private extension SystemKeyboard {

    func rows(for layout: KeyboardLayout) -> some View {
        ForEach(Array(layout.items.enumerated()), id: \.offset) {
            row(for: layout, items: $0.element)
        }
    }

    func row(for layout: KeyboardLayout, items: KeyboardLayoutItemRow) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) {
                self.rowItem($0.element, keyboardWidth, inputWidth)
            }
        }
    }
}

struct SystemKeyboard_Previews: PreviewProvider {

    @ViewBuilder
    static func systemPreviewButtonBuilder(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext) -> some View {
        switch action {
        case .backspace:
            Text("bksp").opacity(0.2).foregroundColor(Color.red)
        default:
            SystemKeyboardActionButtonContent(
                action: action,
                appearance: appearance,
                context: context
            )
        }
    }

    static let actionHandlerPreview = PreviewKeyboardActionHandler()

    @ViewBuilder
    static func systemPreviewRowItem(
        item: KeyboardLayoutItem,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat) -> some View {
        let view = SystemKeyboardButtonRowItem(
            content: systemPreviewButtonBuilder(
                action: item.action,
                appearance: PreviewKeyboardAppearance.preview,
                context: KeyboardContext.preview
            ),
            item: item,
            context: .preview,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: .preview,
            actionHandler: actionHandlerPreview
        )
        switch item.action {
        case .space:
            view.opacity(0.2)
                .overlay(Text("This is an overla over the space bar").multilineTextAlignment(.center))
        default:
            view
        }
    }

    static var previews: some View {
        SystemKeyboard(
            layout: .preview,
            appearance: .preview,
            actionHandler: actionHandlerPreview,
            context: .preview,
            inputContext: .preview,
            secondaryInputContext: .preview,
            width: UIScreen.main.bounds.width,
            rowItem: systemPreviewRowItem
        ).background(Color.yellow)
    }
}
