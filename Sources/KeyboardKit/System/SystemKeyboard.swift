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
 */
public struct SystemKeyboard: View {
    
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        inputCalloutStyle: InputCalloutStyle? = nil,
        secondaryInputCalloutStyle: SecondaryInputCalloutStyle? = nil,
        width: CGFloat = KeyboardInputViewController.shared.view.frame.width,
        buttonBuilder: @escaping ButtonBuilder = Self.standardButtonBuilder) {
        self.layout = layout
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.inputCalloutStyle = inputCalloutStyle
        self.secondaryInputCalloutStyle = secondaryInputCalloutStyle
        self.buttonBuilder = buttonBuilder
        self.keyboardWidth = width
    }
    
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonBuilder: ButtonBuilder
    private let inputCalloutStyle: InputCalloutStyle?
    private var keyboardWidth: CGFloat
    private let layout: KeyboardLayout
    private let secondaryInputCalloutStyle: SecondaryInputCalloutStyle?
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    public typealias ButtonBuilder = (KeyboardAction) -> AnyView
    
    public var body: some View {
        VStack(spacing: 0) {
            rows(for: layout)
        }
        .inputCallout(style: inputCalloutStyle ?? .systemStyle(for: context))
        .secondaryInputCallout(style: secondaryInputCalloutStyle ?? .systemStyle(for: context))
    }
}

public extension SystemKeyboard {
    
    /**
     This is the standard `buttonBuilder`, that will be used
     when no custom builder is provided to the view.
     */
    static func standardButtonBuilder(action: KeyboardAction) -> AnyView {
        AnyView(SystemKeyboardButtonContent(action: action))
    }
}

private extension SystemKeyboard {
    
    func rows(for layout: KeyboardLayout) -> some View {
        let inputWidth = layout.inputWidth(for: keyboardWidth)
        return ForEach(layout.items.enumerated().map { $0 }, id: \.offset) {
            row(for: layout, items: $0.element, inputWidth: inputWidth)
        }
    }
    
    func row(for layout: KeyboardLayout, items: KeyboardLayoutItemRow, inputWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) {
                rowItem(for: layout, item: $0.element, inputWidth: inputWidth)
            }
        }
    }
    
    func rowItem(for layout: KeyboardLayout, item: KeyboardLayoutItem, inputWidth: CGFloat) -> some View {
        buttonBuilder(item.action)
            .frame(maxWidth: .infinity)
            .frame(height: item.size.height - item.insets.top - item.insets.bottom)
            .rowItemWidth(for: item, totalWidth: keyboardWidth, referenceWidth: inputWidth)
            .keyboardButtonStyle(for: item.action, appearance: appearance)
            .padding(item.insets)
            .background(Color.clearInteractable)
            .keyboardGestures(for: item.action, actionHandler: actionHandler)
    }
}

public extension View {
    
    /**
     Apply a certain layout width to the view, in a way that
     works with the rot item composition above.
     */
    @ViewBuilder
    func rowItemWidth(for item: KeyboardLayoutItem, totalWidth: CGFloat, referenceWidth: CGFloat) -> some View {
        let insets = item.insets.leading + item.insets.trailing
        switch item.size.width {
        case .available: self.frame(maxWidth: .infinity)
        case .percentage(let percent): self.frame(width: percent * totalWidth - insets)
        case .points(let points): self.frame(width: points - insets)
        case .reference: self.frame(width: referenceWidth - insets)
        case .useReference: self.frame(width: referenceWidth - insets)
        case .useReferencePercentage(let percent): self.frame(width: percent * referenceWidth - insets)
        }
    }
}
