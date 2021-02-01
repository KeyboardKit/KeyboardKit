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
        actionHandler: KeyboardActionHandler,
        dimensions: KeyboardDimensions = SystemKeyboardDimensions(),
        buttonBuilder: @escaping ButtonBuilder = Self.standardButtonBuilder) {
        self.actionHandler = actionHandler
        self.rows = layout.actionRows
        self.dimensions = dimensions
        self.buttonBuilder = buttonBuilder
    }
    
    private let actionHandler: KeyboardActionHandler
    private let buttonBuilder: ButtonBuilder
    private let dimensions: KeyboardDimensions
    private let rows: KeyboardActionRows
    
    @State private var size: CGSize = .zero
    
    @EnvironmentObject private var context: ObservableKeyboardContext
    @EnvironmentObject private var inputCalloutContext: InputCalloutContext
    
    public typealias ButtonBuilder = (KeyboardAction, KeyboardSize) -> AnyView
    public typealias KeyboardSize = CGSize
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(rows.enumerated().map { $0 }, id: \.offset) {
                row(at: $0.offset, actions: $0.element)
            }
        }
        .bindSize(to: $size)
        .inputCallout(context: inputCalloutContext, style: .systemStyle(for: context))
        .secondaryInputCallout(for: context, style: .systemStyle(for: context))
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
            rowEdgeSpacer(at: index)
            ForEach(Array(actions.enumerated()), id: \.offset) {
                SystemKeyboardButtonRowItem(
                    action: $0.element,
                    actionHandler: actionHandler,
                    buttonContent: buttonBuilder($0.element, size),
                    keyboardSize: size)
            }
            rowEdgeSpacer(at: index)
        }
    }
    
    @ViewBuilder
    func rowEdgeSpacer(at index: Int) -> some View {
        if index == 1 {
            Spacer(minLength: secondRowPadding)
        } else {
            EmptyView()
        }
    }
    
    /**
     A temp. way to get side padding on each side on English
     iPhone keyboards.
     */
    var secondRowPadding: CGFloat {
        guard Locale.current.identifier.starts(with: "en") else { return 0 }
        guard UIDevice.current.userInterfaceIdiom == .phone else { return 0 }
        return max(0, 20 * CGFloat(rows[0].count - rows[1].count))
    }
}
