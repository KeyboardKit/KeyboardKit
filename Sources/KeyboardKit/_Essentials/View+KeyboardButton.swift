//
//  View+Buttons.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Bind keyboard button styles and gestures to the view.
    ///
    /// The `edgeInsets` init parameter can be used to apply
    /// intrinsic insets within the interactable button area.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger.
    ///   - style: The keyboard style to apply.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - keyboardContext: The keyboard context to use.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - additionalTapArea: An additional tap area in point to add outside the button.
    ///   - edgeInsets: The edge insets to apply to the interactable area, if any.
    ///   - isPressed: An optional binding that can observe the button pressed state.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: The percentage of the button size that spans outside the button and still counts as a release, by default `1`.
    func keyboardButton(
        for action: KeyboardAction,
        style: Keyboard.ButtonStyle,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        keyboardContext: KeyboardContext,
        calloutContext: KeyboardCalloutContext?,
        additionalTapArea: Double = 0,
        edgeInsets: EdgeInsets = .init(),
        isPressed: Binding<Bool> = .constant(false),
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double = 1
    ) -> some View {
        self
            .background(Keyboard.ButtonKey())
            .keyboardButtonStyle(style)
            .foregroundColor(style.foregroundColor)
            .font(style.font)
            .padding(edgeInsets)
            .background(Color.clearInteractable)
            .additionalTapArea(
                additionalTapArea,
                for: action,
                actionHandler: actionHandler
            )
            .keyboardButtonGestures(
                for: action,
                actionHandler: actionHandler,
                repeatTimer: repeatTimer,
                calloutContext: calloutContext,
                isPressed: isPressed,
                scrollState: scrollState,
                releaseOutsideTolerance: releaseOutsideTolerance
            )
            .localeContextMenu(
                for: action,
                context: keyboardContext,
                actionHandler: actionHandler
            )
            .keyboardButtonAccessibility(for: action)
    }

    /// Apply keyboard accessibility for the provided action.
    @ViewBuilder
    func keyboardButtonAccessibility(
        for action: KeyboardAction
    ) -> some View {
        if let label = action.standardAccessibilityLabel {
            self.accessibilityElement()
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel(label)
        } else {
            self.accessibilityHidden(true)
        }
    }
}

private extension View {

    @ViewBuilder
    func additionalTapArea(
        _ points: Double,
        for action: KeyboardAction,
        actionHandler: KeyboardActionHandler
    ) -> some View {
        self.zIndex(points)
            .background(
                Color.clearInteractable
                    .padding(-points)
                    #if os(iOS)
                    .onTapGesture {
                        actionHandler.handle(.press, on: action)
                        actionHandler.handle(.release, on: action)
                    }
                    #endif
            )
    }

    @ViewBuilder
    func localeContextMenu(
        for action: KeyboardAction,
        context: KeyboardContext,
        actionHandler: KeyboardActionHandler
    ) -> some View {
        if shouldApplyLocaleContextMenu(for: action, context: context) {
            self.localeContextMenu(for: context) {
                actionHandler.handle(.release, on: action)
            }
            .id(context.locale.identifier)
        } else {
            self
        }
    }

    func shouldApplyLocaleContextMenu(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Bool {
        switch action {
        case .nextLocale: true
        case .space: context.spaceLongPressBehavior == .openLocaleContextMenu
        default: false
        }
    }
}

#Preview {

    struct Preview: View {

        @State
        var isPressed = false

        @State
        var context: KeyboardContext = {
            let context = KeyboardContext()
            context.locales = .keyboardKitSupported
            context.localePresentationLocale = .swedish
            context.spaceLongPressBehavior = .openLocaleContextMenu
            return context
        }()

        var body: some View {
            VStack {
                VStack(spacing: 20) {
                    button(for: Text("a"), style: .preview1)
                    button(
                        for: Text("A"),
                        style: .preview2,
                        insets: .init(top: 5, leading: 10, bottom: 15, trailing: 20)
                    )
                    button(
                        for: Text(context.locale.identifier),
                        action: .nextLocale,
                        style: .preview1
                    )
                    button(for: Image.keyboardGlobe, style: .preview1)
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20)

                Text("\(isPressed ? "Pressed": "Not Pressed")")
            }
        }

        func button<Content: View>(
            for content: Content,
            action: KeyboardAction = .backspace,
            style: Keyboard.ButtonStyle,
            insets: EdgeInsets = .init()
        ) -> some View {
            content
                .padding()
                .keyboardButton(
                    for: action,
                    style: style,
                    actionHandler: .preview,
                    keyboardContext: context,
                    calloutContext: .preview,
                    edgeInsets: insets,
                    isPressed: $isPressed
                )
        }
    }

    return Preview()
}
