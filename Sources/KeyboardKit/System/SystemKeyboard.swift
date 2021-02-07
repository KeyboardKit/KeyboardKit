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
 buttons are then wrapped in a `SystemKeyboardButtonRowItem`.
 */
public struct SystemKeyboard: View {
    
    public init(
        layout: KeyboardLayout,
        appearance: KeyboardAppearance,
        actionHandler: KeyboardActionHandler,
        inputCalloutStyle: InputCalloutStyle? = nil,
        secondaryInputCalloutStyle: SecondaryInputCalloutStyle? = nil,
        buttonBuilder: @escaping ButtonBuilder = Self.standardButtonBuilder) {
        self.layout = layout
        self.actionHandler = actionHandler
        self.appearance = appearance
        self.rows = layout.rows
        self.inputCalloutStyle = inputCalloutStyle
        self.secondaryInputCalloutStyle = secondaryInputCalloutStyle
        self.buttonBuilder = buttonBuilder
    }
    
    private let actionHandler: KeyboardActionHandler
    private let appearance: KeyboardAppearance
    private let buttonBuilder: ButtonBuilder
    private let rows: KeyboardActionRows
    private let inputCalloutStyle: InputCalloutStyle?
    private let layout: KeyboardLayout
    private let secondaryInputCalloutStyle: SecondaryInputCalloutStyle?
    
    @State private var keyboardSize: CGSize = .zero
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    
    public typealias ButtonBuilder = (KeyboardAction, KeyboardSize) -> AnyView
    public typealias KeyboardSize = CGSize
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(rows.enumerated().map { $0 }, id: \.offset) {
                row(at: $0.offset, actions: $0.element)
            }
        }
        .bindSize(to: $keyboardSize)
        .inputCallout(style: inputCalloutStyle ?? .systemStyle(for: context))
        .secondaryInputCallout(style: secondaryInputCalloutStyle ?? .systemStyle(for: context))
    }
}

public extension SystemKeyboard {
    
    /**
     This is the standard `buttonBuilder`, that will be used
     when no custom builder is provided to the view.
     */
    static func standardButtonBuilder(action: KeyboardAction, keyboardSize: KeyboardSize) -> AnyView {
        AnyView(SystemKeyboardButtonContent(action: action))
    }
}

private extension SystemKeyboard {
    
    func row(at index: Int, actions: KeyboardActions) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(actions.enumerated()), id: \.offset) {
                SystemKeyboardButtonRowItem(
                    action: $0.element,
                    actionHandler: actionHandler,
                    appearance: appearance,
                    buttonContent: buttonBuilder($0.element, keyboardSize),
                    layout: layout)
            }
        }
    }
}
