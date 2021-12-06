//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics native iOS system keyboards, like standard
 alphabetic, numeric and symbolic system keyboards.
 
 There are three ways to create a system keyboard. The first
 is to use the builder-less initializer to create a standard
 system keyboard with standard buttons. The second is to use
 the `buttonContentBuilder` initializer to create a keyboard
 that customizes each button's internal content, but without
 affecting the button's shape, paddings etc. The third is to
 use the `buttonViewBuilder` initializer to create keyboards
 where the entire button view can be replaced.
 
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
     Create a system keyboard that uses a `buttonViewBuilder`
     to generate the entire button view for each layout item.
     
     The `buttonContentBuilder` initializer creates a system
     keyboard that just replaces the internal button content
     a
     
     
     you just want to replace the button's intrinsic content.
     
     You can use the initializer that doesn't have a builder
     when you just want to create a standard system keyboard.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonViewBuilder: @escaping ButtonViewBuilder) {
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
    private let buttonViewBuilder: ButtonViewBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let layout: KeyboardLayout
    private let layoutConfig: KeyboardLayoutConfiguration
    
    public typealias ButtonViewBuilder = (KeyboardLayoutItem, KeyboardWidth, KeyboardItemWidth) -> ButtonView
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
            itemRows(for: layout)
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

private extension SystemKeyboard {

    func itemRows(for layout: KeyboardLayout) -> some View {
        ForEach(Array(layout.items.enumerated()), id: \.offset) {
            items(for: layout, itemRow: $0.element)
        }
    }

    func items(for layout: KeyboardLayout, itemRow: KeyboardLayoutItemRow) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(itemRow.enumerated()), id: \.offset) {
                buttonViewBuilder($0.element, keyboardWidth, inputWidth)
            }
        }
    }
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<AnyView> {
    
    /**
     Create a keyboard that uses a `buttonContentBuilder` to
     generate the button view's content for each layout item.
     
     You can use the `buttonViewBuilder` initializer when it
     should replace the entire button view instead.
     
     You can use the initializer that doesn't have a builder
     when you just want to create a standard system keyboard.
     */
    init<ButtonContentView: View>(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth,
        @ViewBuilder buttonContentBuilder: @escaping (KeyboardLayoutItem) -> ButtonContentView) {
        self.init(
            layout: layout,
            appearance: appearance,
            actionHandler: actionHandler,
            context: context,
            inputContext: inputContext,
            secondaryInputContext: secondaryInputContext,
            width: width,
            buttonViewBuilder: { item, keyboardWidth, inputWidth in
                SystemKeyboardButtonRowItem(
                    content: AnyView(buttonContentBuilder(item)),
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
}

public extension SystemKeyboard where ButtonView == SystemKeyboardButtonRowItem<SystemKeyboardActionButtonContent> {
    
    /**
     Create a system keyboard that creates a standard button
     view for each layout item.
     
     You can use the `buttonViewBuilder` initializer when it
     should replace the entire button view instead.
     
     You can use the `buttonContentBuilder` initializer when
     you just want to replace the button's intrinsic content.
     */
    init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        context: KeyboardContext,
        inputContext: InputCalloutContext?,
        secondaryInputContext: SecondaryInputCalloutContext?,
        width: CGFloat = standardKeyboardWidth) {
        self.init(
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
                context: .preview,
                inputContext: nil,
                secondaryInputContext: nil,
                width: UIScreen.main.bounds.width)
            
            
            // A keyboard that replaces the button content
            SystemKeyboard(
                layout: .preview,
                appearance: PreviewKeyboardAppearance(),
                actionHandler: PreviewKeyboardActionHandler(),
                context: .preview,
                inputContext: nil,
                secondaryInputContext: nil,
                width: UIScreen.main.bounds.width,
                buttonContentBuilder: previewButtonContent)
            
            // A keyboard that replaces entire button views
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
