//
//  View+Buttons.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// This view modifier can be used to convert views into
    /// keyboard button that triggers a certain action.
    ///
    /// This view will apply correct styles for the provided
    /// action and style, and will apply correct gestures to
    /// make sure that the action handler is used correctly.
    ///
    /// The `edgeInsets` init parameter can be used to apply
    /// intrinsic insets within the interactable button area.
    ///
    /// The reason why this view modifier exists, is that it
    /// is used by both the keyboard button and the keyboard
    /// view item. We should consolidate these two views, to
    /// make the architecture less confusing.
    ///
    /// - Parameters:
    ///   - action: The keyboard action to trigger.
    ///   - style: The keyboard style to apply.
    ///   - actionHandler: The keyboard action handler to use.
    ///   - repeatTimer: The repeat gesture timer to use, if any.
    ///   - keyboardContext: The keyboard context to use.
    ///   - calloutContext: The callout context to affect, if any.
    ///   - additionalTapArea: An additional tap area in points, if any.
    ///   - edgeInsets: The edge insets to apply to the interactable area, if any.
    ///   - isPressed: An optional binding that can observe the button pressed state.
    ///   - isGestureAutoCancellable: Whether an aborted gesture will auto-cancel itself, by default `false`.
    ///   - scrollState: The scroll state to use, if any.
    ///   - releaseOutsideTolerance: The button sized percentage outside the button that still counts as a release, by default `1`.
    func keyboardButton(
        for action: KeyboardAction,
        style: Keyboard.ButtonStyle,
        actionHandler: KeyboardActionHandler,
        repeatTimer: GestureButtonTimer? = nil,
        keyboardContext: KeyboardContext,
        calloutContext: CalloutContext?,
        additionalTapArea: Double? = nil,
        edgeInsets: EdgeInsets = .init(),
        isPressed: Binding<Bool> = .constant(false),
        isGestureAutoCancellable: Bool? = nil,
        scrollState: GestureButtonScrollState? = nil,
        releaseOutsideTolerance: Double? = nil
    ) -> some View {
        return self
            .background(Keyboard.ButtonKey())
            .keyboardButtonStyle(style)
            .foregroundColor(style.foregroundColor)
            .font(font(
                for: style,
                action: action,
                context: keyboardContext
            ))
            .overlay(overlayColor(for: isPressed, style: style).cornerRadius(style.cornerRadius ?? 0))
            .padding(edgeInsets)
            .background(Color.clearInteractable)
            .additionalTapArea(
                additionalTapArea ?? 0,
                for: action,
                actionHandler: actionHandler
            )
            .keyboardButtonGestures(
                for: action,
                actionHandler: actionHandler,
                repeatTimer: repeatTimer,
                calloutContext: calloutContext,
                isPressed: isPressed,
                isGestureAutoCancellable: isGestureAutoCancellable,
                scrollState: scrollState,
                releaseOutsideTolerance: releaseOutsideTolerance ?? 1
            )
            .localeContextMenu(
                for: action,
                context: keyboardContext,
                actionHandler: actionHandler
            )
            .keyboardButtonAccessibility(for: action)
    }

    func font(
        for style: Keyboard.ButtonStyle,
        action: KeyboardAction,
        context: KeyboardContext
    ) -> Font {
        let standard = action.standardButtonFont
        let font = style.font ?? standard(context).font
        if let weight = style.fontWeight {
            return font.weight(weight.fontWeight)
        } else {
            return font
        }
    }

    /// Apply keyboard accessibility for the provided action.
    @ViewBuilder
    func keyboardButtonAccessibility(
        for action: KeyboardAction
    ) -> some View {
        if let label = action.accessibilityLabel {
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

    @ViewBuilder
    func preferredFontWeight(
        _ weight: KeyboardFont.FontWeight?
    ) -> some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 10.0, *) {
            self.fontWeight(weight?.fontWeight)
        } else {
            self
        }
    }
}

private extension View {
    
    func isSpaceContextMenuEnabled(
        for context: KeyboardContext
    ) -> Bool {
        context.settings.spaceLongPressBehavior == .openLocaleContextMenu
    }

    func overlayColor(
        for isPressed: Binding<Bool>,
        style: Keyboard.ButtonStyle
    ) -> Color {
        guard isPressed.wrappedValue else { return .clear }
        return style.pressedOverlayColor ?? .clear
    }

    func shouldApplyLocaleContextMenu(
        for action: KeyboardAction,
        context: KeyboardContext
    ) -> Bool {
        switch action {
        case .nextLocale: true
        case .space: isSpaceContextMenuEnabled(for: context)
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
            context.settings.spaceLongPressBehavior = .openLocaleContextMenu
            return context
        }()

        var body: some View {
            VStack {
                VStack(spacing: 20) {
                    button(
                        for: Text("a"),
                        action: .character("A"),
                        style: .init(
                            backgroundColor: .purple,
                            fontWeight: .regular
                        )
                    )
                    button(
                        for: Text("A"),
                        action: .character("A"),
                        style: .init(
                            backgroundColor: .teal,
                            fontWeight: .heavy,
                            cornerRadius: 20
                        ),
                        insets: .init(top: 5, leading: 10, bottom: 15, trailing: 20)
                    )
                    button(
                        for: Text(context.locale.identifier),
                        action: .nextLocale,
                        style: .init(backgroundColor: .orange)
                    )
                    button(
                        for: Image.keyboardGlobe,
                        action: .nextLocale,
                        style: .init(backgroundColor: .mint)
                    )
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20)

                Text("\(isPressed ? "Pressed": "Not Pressed")")
            }
        }

        func button<Content: View>(
            for content: Content,
            action: KeyboardAction,
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
                    isPressed: $isPressed,
                    isGestureAutoCancellable: true
                )
        }
    }

    return Preview()
}
