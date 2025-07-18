//
//  Callouts+ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {

    /// This callout can show secondary callout actions when
    /// long pressing input keys with secondary actions.
    ///
    /// This callout will adjust the button corner radius to
    /// fit the style's or the keyboard layout configuration.
    struct ActionCallout: View {
        
        /// Create an action callout.
        ///
        /// - Parameters:
        ///   - calloutContext: The callout context to use.
        ///   - keyboardContext: The keyboard context to use.
        public init(
            calloutContext: CalloutContext,
            keyboardContext: KeyboardContext
        ) {
            self._calloutContext = .init(wrappedValue: calloutContext)
            self._keyboardContext = .init(wrappedValue: keyboardContext)
        }

        @ObservedObject private var calloutContext: CalloutContext
        @ObservedObject private var keyboardContext: KeyboardContext

        @Environment(\.emojiKeyboardStyle) private var emojiStyle
        @Environment(\.keyboardCalloutStyle) private var style

        public var body: some View {
            Button(action: calloutContext.resetSecondaryActions) {
                VStack(alignment: alignment, spacing: 0) {
                    calloutBubble
                    calloutButton
                }
            }
            .buttonStyle(.plain)
            .compositingGroup()
            .opacity(isActive ? 1 : 0)
            .keyboardCalloutShadow(style: style)
            .position(position)
            .offset(y: verticalOffset)
        }
    }
}

private extension Callouts.ActionCallout {

    var calloutBubble: some View {
        HStack(spacing: 0) {
            ForEach(Array(actions.enumerated()), id: \.offset) {
                calloutItem(for: $0.element)
                    .frame(width: itemSize.width, height: itemSize.height)
                    .background(isSelected($0.offset) ? style.selectedBackgroundColor : .clear)
                    .foregroundColor(isSelected($0.offset) ? style.selectedForegroundColor : style.foregroundColor)
                    .cornerRadius(style.cornerRadius)
                    .padding(.horizontal, style.actionItemPadding.width)
                    .padding(.vertical, style.actionItemPadding.height)
            }
        }
        .padding(.horizontal, style.curveSize.width)
        .background(style.backgroundColor)
        .cornerRadius(style.cornerRadius)
    }

    var calloutButton: some View {
        ButtonArea(
            frame: buttonFrame,
            buttonCornerRadius: style.buttonCornerRadius(for: keyboardContext)
        )
        .opacity(isPad ? 0 : 1)
        .rotation3DEffect(isLeading ? .zero : .degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
    }

    @ViewBuilder
    func calloutItem(for action: KeyboardAction) -> some View {
        switch action {
        case .character(let char): calloutItem(for: char)
        case .emoji(let emoji): calloutItem(for: emoji)
        case .text(let text): calloutItem(for: text)
        default: EmptyView()
        }
    }

    func calloutItem(for char: String) -> some View {
        Text(char)
            .font(style.actionItemFont.font)
            .fixedSize(horizontal: true, vertical: false)
    }

    func calloutItem(for emoji: Emoji) -> some View {
        let style = emojiStyle(keyboardContext)
        return Text(emoji.char)
            .font(style.itemFont)
            .scaleEffect(style.itemScaleFactor)
            .frame(
                width: style.itemSize,
                height: style.itemSize,
                alignment: .center
            )
    }
}

private extension Callouts.ActionCallout {

    var actions: [KeyboardAction] {
        calloutContext.secondaryActions
    }

    var isActive: Bool {
        !actions.isEmpty
    }

    var isEmojiCallout: Bool {
        actions.first?.isEmojiAction ?? false
    }

    var isLeading: Bool {
        calloutContext.secondaryActionsAlignment == .leading
    }

    var isPad: Bool {
        keyboardContext.deviceTypeForKeyboard == .pad
    }

    func isSelected(_ offset: Int) -> Bool {
        calloutContext.secondaryActionsIndex == offset
    }

    var isTextCallout: Bool {
        guard let action = actions.first else { return false }
        switch action {
        case .text: return true
        default: return false
        }
    }
}

private extension Callouts.ActionCallout {

    var alignment: HorizontalAlignment {
        calloutContext.secondaryActionsAlignment
    }

    var buttonSize: CGSize {
        buttonFrame.size
    }

    var buttonFrame: CGRect {
        if isEmojiCallout { return calloutContext.buttonFrame }
        return buttonFrameForCharacters
    }

    var buttonFrameForCharacters: CGRect {
        let inset = style.buttonOverlayInset
        return calloutContext.buttonFrame
            .insetBy(dx: inset.width, dy: inset.height)
    }

    var itemSize: CGSize {
        let frameSize = buttonSize
        let width = frameSize.width
        let height = frameSize.height
        let buttonSize = CGSize(width: width * itemSizeWidthScale, height: height)
        let limitedSize = buttonSize.limited(to: style.actionItemMaxSize)
        return limitedSize
    }
    
    var itemSizeWidthScale: Double {
        if actions.count == 1 { return 1.4 }
        if useCompressedButtonSize { return calloutContext.compressedWidthScale }
        return 1
    }

    var verticalOffset: CGFloat {
        style.offset?.y ?? style.standardVerticalOffset(for: keyboardContext.deviceTypeForKeyboard)
    }

    var position: CGPoint {
        CGPoint(x: positionX, y: positionY)
    }

    var positionX: CGFloat {
        let buttonWidth = itemSize.width
        let adjustment = (CGFloat(actions.count) * buttonWidth)/2
        let widthDiff = buttonWidth - buttonFrame.size.width
        let signedAdjustment = isLeading ? adjustment : -adjustment + buttonWidth - widthDiff
        return buttonFrame.origin.x + signedAdjustment
    }

    var positionY: CGFloat {
        buttonFrame.origin.y - style.actionItemPadding.height
    }
    
    var useCompressedButtonSize: Bool {
        keyboardContext.deviceTypeForKeyboard == .phone && actions.count > 10
    }
}

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): char
        case .text(let text): text
        default: nil
        }
    }
}

#if !os(tvOS)
#Preview {

    struct PreviewGroup: View {

        let color: Color
        let context: CalloutContext
        let action: KeyboardAction
        let alignment: HorizontalAlignment

        let startActions = Callouts.Actions.base

        @Environment(\.keyboardCalloutActions) var envActions
        @EnvironmentObject var keyboardContext: KeyboardContext

        func showActions(
            _ actions: Callouts.Actions?,
            in geo: GeometryProxy
        ) {
            showActions(actions?.actions(for: action), in: geo)
        }

        func showActions(
            _ actions: [KeyboardAction]?,
            in geo: GeometryProxy
        ) {
            context.updateSecondaryActions(
                actions,
                for: action,
                in: geo,
                alignment: alignment
            )
        }

        var body: some View {
            color
                .overlay(calloutTrigger)
                .keyboardActionCalloutContainer(
                    calloutContext: context,
                    keyboardContext: keyboardContext
                )
                .frame(width: 35, height: 50)
        }

        var calloutTrigger: some View {
            GeometryReader { geo in
                Color.white.opacity(0.1)
                    .onAppear {
                        showActions(startActions, in: geo)
                    }
                    .onTapGesture {
                        showActions(envActions(.init(action: action)), in: geo)
                    }
            }
        }
    }

    struct Preview: View {

        let action = KeyboardAction.character("o")

        @StateObject var calloutContext1 = CalloutContext()
        @StateObject var calloutContext2 = CalloutContext()
        @StateObject var keyboardContext = KeyboardContext()

        var body: some View {
            VStack(spacing: 100) {
                HStack {
                    PreviewGroup(
                        color: .blue,
                        context: calloutContext1,
                        action: action,
                        alignment: .leading
                    )
                    Spacer()
                }
                HStack {
                    Spacer()
                    PreviewGroup(
                        color: .yellow,
                        context: calloutContext2,
                        action: action,
                        alignment: .trailing
                    )
                }
            }
            .padding(20)
            .background(Color.red)
            .environmentObject(keyboardContext)
            .keyboardCalloutStyle(.init(
                // callout: .preview2,
                selectedBackgroundColor: .purple
            ))
        }
    }

    return Preview()
        .keyboardCalloutActions { params in
            // [params.action, .character("b")]
                .urlDomainActions
        }
}
#endif
