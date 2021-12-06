//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This typealias represents a function that is used to create
 button views for a `SystemKeyboard`.
 */
public typealias SystemKeyboardButtonContentBuilder<ItemContent> = (KeyboardAction, KeyboardAppearance, KeyboardContext) -> ItemContent

/**
 This view mimics native iOS system keyboards, like standard
 alphabetic, numeric and symbolic system keyboards.
 
 The keyboard view takes a `keyboardLayout` and converts the
 actions to buttons, using the provided `buttonBuilder`. The
 buttons are then wrapped in a view that applies styling and
 gestures to the provided view.
 
 Since the widths of the keyboard buttons will depend on the
 total keyboard width, the view must be given a `width` when
 it's created. If you don't provide a width, it will use the
 width of the shared input view controller view.
 
 `IMPORTANT` In previews, you must provide a custom width to
 get buttons to show up, since there is no shared controller.
 */
public struct SystemKeyboard<ButtonView: View>: View {

    /**
     Create a system keyboard that uses a `buttonViewBuilder`
     to generate the entire button view for each layout item.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
        @ViewBuilder buttonViewBuilder: @escaping ButtonBuilder) {
        self.layout = layout
        self.layoutConfig = .standard(for: context)
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.keyboardWidth = width
        self.buttonViewBuilder = buttonViewBuilder
        self.inputWidth = layout.inputWidth(for: width)
        _context = ObservedObject(wrappedValue: context)
        _inputContext = ObservedObject(wrappedValue: inputContext ?? .disabled)
        _secondaryInputContext = ObservedObject(wrappedValue: secondaryInputContext ?? .disabled)
    }

    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonViewBuilder: ButtonBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayoutConfiguration
    
    public typealias ButtonBuilder = (KeyboardLayoutItem, KeyboardWidth, KeyboardItemWidth) -> ButtonView
    public typealias ButtonContentBuilder<ButtonContent: View> = (KeyboardAction, KeyboardAppearance, KeyboardContext) -> ButtonContent
    public typealias KeyboardWidth = CGFloat
    public typealias KeyboardItemWidth = CGFloat

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
        width: width,
        buttonViewBuilder: { item, keyboardWidth, inputWidth in
            SystemKeyboardButtonRowItem(
                content: SystemKeyboardActionButtonContent(
                    action: item.action,
                    appearance: appearance,
                    context: context),
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
    buttonContentBuilder: @escaping SystemKeyboardButtonContentBuilder<ButtonContent>) -> some View {
    SystemKeyboard(
        layout: layout,
        appearance: appearance,
        actionHandler: actionHandler,
        context: context,
        inputContext: inputContext,
        secondaryInputContext: secondaryInputContext,
        width: width,
        buttonViewBuilder: { item, keyboardWidth, inputWidth in
            SystemKeyboardButtonRowItem(
                content: buttonContentBuilder(item.action, appearance, context),
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

private extension SystemKeyboard {

    func rows(for layout: KeyboardLayout) -> some View {
        ForEach(Array(layout.items.enumerated()), id: \.offset) {
            row(for: layout, items: $0.element)
        }
    }

    func row(for layout: KeyboardLayout, items: KeyboardLayoutItemRow) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) {
                buttonViewBuilder($0.element, keyboardWidth, inputWidth)
            }
        }
    }
}

struct SystemKeyboard_Previews: PreviewProvider {
    
    static let actionHandler = PreviewKeyboardActionHandler()

    @ViewBuilder
    static func previewButtonContent(
        action: KeyboardAction,
        appearance: KeyboardAppearance,
        context: KeyboardContext) -> some View {
        switch action {
        case .backspace:
            Text("<-").opacity(0.2).foregroundColor(Color.red)
        default:
            SystemKeyboardActionButtonContent(
                action: action,
                appearance: appearance,
                context: context
            )
        }
    }

    @ViewBuilder
    static func previewButton(
        item: KeyboardLayoutItem,
        keyboardWidth: CGFloat,
        inputWidth: CGFloat) -> some View {
        let view = SystemKeyboardButtonRowItem(
            content: previewButtonContent(
                action: item.action,
                appearance: PreviewKeyboardAppearance.preview,
                context: KeyboardContext.preview
            ),
            item: item,
            context: .preview,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: .preview,
            actionHandler: actionHandler
        )
        switch item.action {
        case .space:
            view.opacity(0.2)
                .overlay(Text("This is a space bar overlay").multilineTextAlignment(.center))
        default:
            view
        }
    }

    static var previews: some View {
        VStack {
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                context: .preview,
                inputContext: nil,
                secondaryInputContext: nil,
                width: UIScreen.main.bounds.width,
                buttonViewBuilder: previewButton)
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                context: .preview,
                inputContext: nil,
                secondaryInputContext: nil,
                width: UIScreen.main.bounds.width,
                buttonViewBuilder: previewButton)
        }.background(Color.yellow)
    }
}
