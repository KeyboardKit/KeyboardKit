//
//  SystemKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

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
public struct SystemKeyboard: View {
    
    /**
     Create an autocomplete toolbar.
     
     - Parameters:
       - layout: The keyboard layout to use in the keyboard.
       - appearance: The keyboard appearance to use in the keyboard.
       - actionHandler: The action handler to use in the keyboard.
       - width: The total width of the keyboard, used for button size calculations.
       - buttonBuilder: An optional, custom button builder. By default, the static `standardButton` will be used.
     */
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
        buttonBuilder: @escaping ButtonBuilder = Self.standardButtonBuilder) {
        self.layout = layout
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.buttonBuilder = buttonBuilder
        self.keyboardWidth = width
        self.inputWidth = layout.inputWidth(for: keyboardWidth)
            
        // Temporary until everything uses style ***********
        // let layoutConfig = KeyboardLayoutConfiguration.standard(for: context)
        // var inputStyle = inputCalloutStyle
        // inputStyle.callout.buttonCornerRadius = layoutConfig.buttonCornerRadius
        // self.inputCalloutStyle = inputStyle
        // var secondaryStyle = secondaryInputCalloutStyle
        // secondaryStyle.callout = inputStyle.callout
        // self.secondaryInputCalloutStyle = secondaryStyle
        // Temporary until everything uses style ***********
    }
    
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonBuilder: ButtonBuilder
    private let keyboardWidth: CGFloat
    private let inputWidth: CGFloat
    private let layout: KeyboardLayout
    
    @EnvironmentObject private var context: KeyboardContext
    @EnvironmentObject private var inputContext: InputCalloutContext
    @EnvironmentObject private var secondaryInputContext: SecondaryInputCalloutContext
    
    /**
     This typealias represents the action block that is used
     to create button views for the system keyboard.
     */
    public typealias ButtonBuilder = (KeyboardAction, KeyboardAppearance) -> AnyView
    
    public var body: some View {
        VStack(spacing: 0) {
            rows(for: layout)
        }
        .inputCallout(context: inputContext, style: .standard)
        .secondaryInputCallout(context: secondaryInputContext, style: .standard)
    }
}

public extension SystemKeyboard {
    
    /**
     This is the standard `buttonBuilder`, that will be used
     when no custom builder is provided to the view.
     */
    static func standardButtonBuilder(
        action: KeyboardAction,
        appearance: KeyboardAppearance) -> AnyView {
        AnyView(SystemKeyboardActionButtonContent(
            action: action,
            appearance: appearance)
        )
    }
}

private extension SystemKeyboard {
    
    func rows(for layout: KeyboardLayout) -> some View {
        ForEach(layout.items.enumerated().map { $0 }, id: \.offset) {
            row(for: layout, items: $0.element)
        }
    }
    
    func row(for layout: KeyboardLayout, items: KeyboardLayoutItemRow) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) {
                rowItem(for: layout, item: $0.element)
            }
        }
    }
    
    func rowItem(for layout: KeyboardLayout, item: KeyboardLayoutItem) -> some View {
        SystemKeyboardButtonRowItem(
            content: buttonBuilder(item.action, appearance),
            item: item,
            context: context,
            keyboardWidth: keyboardWidth,
            inputWidth: inputWidth,
            appearance: appearance,
            actionHandler: actionHandler)
    }
}

struct SystemKeyboard_Previews: PreviewProvider {
    
    static var previews: some View {
        SystemKeyboard(
            layout: .preview,
            appearance: .preview,
            actionHandler: PreviewKeyboardActionHandler(),
            width: UIScreen.main.bounds.width
        )
        .keyboardPreview()
        .background(Color.standardKeyboardBackground)
    }
}
