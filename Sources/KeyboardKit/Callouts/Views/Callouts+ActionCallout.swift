//
//  Callouts+ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {
    
    /// This callout can show secondary callout actions when
    /// a user long presser certain input keys.
    ///
    /// This callout will adjust the provided style's button
    /// corner radius to fit the layout configuration of the
    /// callout context.
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
            self._calloutContext = ObservedObject(wrappedValue: calloutContext)
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        }

        @ObservedObject
        private var calloutContext: CalloutContext

        @ObservedObject
        private var keyboardContext: KeyboardContext

        @Environment(\.emojiKeyboardStyle)
        private var emojiStyle: Emoji.KeyboardStyle.Builder

        @Environment(\.calloutStyle)
        private var style

        public var body: some View {
            Button(action: calloutContext.resetSecondaryActions) {
                VStack(alignment: calloutContext.secondaryActionsAlignment, spacing: 0) {
                    callout
                    buttonArea
                }
            }
            .buttonStyle(.plain)
            .font(style.actionItemFont.font)
            .compositingGroup()
            .opacity(calloutContext.secondaryActions.isEmpty ? 0 : 1)
            .keyboardCalloutShadow(style: style)
            .position(x: positionX, y: positionY)
            .offset(y: style.offset?.y ?? style.standardVerticalOffset(for: keyboardContext.deviceTypeForKeyboard))
        }
    }
}


// MARK: - Private Properties

private extension Callouts.ActionCallout {
    
    var backgroundColor: Color { style.backgroundColor }

    var buttonFrame: CGRect { isEmojiCallout ? buttonFrameForEmojis : buttonFrameForCharacters }
    
    var buttonFrameSize: CGSize { buttonFrame.size }
    
    var buttonFrameForCharacters: CGRect { calloutContext.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    
    var buttonFrameForEmojis: CGRect { calloutContext.buttonFrame }
    
    var buttonInset: CGSize { style.buttonOverlayInset }

    var calloutActions: [KeyboardAction] { calloutContext.secondaryActions }

    var calloutButtonSize: CGSize {
        let frameSize = buttonFrame.size
        let widthScale = (calloutActions.count == 1) ? 1.2 : 1
        let buttonSize = CGSize(width: frameSize.width * widthScale, height: frameSize.height)
        return buttonSize.limited(to: style.actionItemMaxSize)
    }
    
    var cornerRadius: CGFloat { style.cornerRadius }

    var curveSize: CGSize { style.curveSize }

    var isLeading: Bool { calloutContext.secondaryActionsAlignment == .leading }

    var isTrailing: Bool { !isLeading }

    var buttonArea: some View {
        ButtonArea(frame: buttonFrame)
            .opacity(isPad ? 0 : 1)
            .rotation3DEffect(isTrailing ? .degrees(180) : .zero, axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutActions.enumerated()), id: \.offset) {
                calloutView(for: $0.element)
                    .frame(width: calloutButtonSize.width, height: calloutButtonSize.height)
                    .background(isSelected($0.offset) ? style.selectedBackgroundColor : .clear)
                    .foregroundColor(isSelected($0.offset) ? style.selectedForegroundColor : style.foregroundColor)
                    .cornerRadius(cornerRadius)
                    .padding(.horizontal, style.actionItemPadding.width)
                    .padding(.vertical, style.actionItemPadding.height)
            }
        }
        .padding(.horizontal, curveSize.width)
        .background(calloutBackground)
    }
    
    var calloutBackground: some View {
        CustomRoundedRectangle(
            topLeft: cornerRadius,
            topRight: cornerRadius,
            bottomLeft: cornerRadius,
            bottomRight: cornerRadius
        )
        .foregroundColor(backgroundColor)
    }

    @ViewBuilder
    func calloutView(for action: KeyboardAction) -> some View {
        switch action {
        case .character(let char): calloutView(for: char)
        case .emoji(let emoji): calloutView(for: emoji)
        default: EmptyView()
        }
    }

    func calloutView(for character: String) -> some View {
        Text(character)
    }

    func calloutView(for emoji: Emoji) -> some View {
        calloutView(for: emoji, style: emojiStyle(keyboardContext))
    }

    func calloutView(
        for emoji: Emoji,
        style: Emoji.KeyboardStyle
    ) -> some View {
        Text(emoji.char)
            .font(style.itemFont)
            .scaleEffect(style.itemScaleFactor)
            .frame(
                width: style.itemSize,
                height: style.itemSize,
                alignment: .center
            )
    }

    var positionX: CGFloat {
        let buttonWidth = calloutButtonSize.width
        let adjustment = (CGFloat(calloutActions.count) * buttonWidth)/2
        let widthDiff = buttonWidth - buttonFrameSize.width
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth - widthDiff : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.actionItemPadding.height
    }
}


// MARK: - Private Functions

private extension Callouts.ActionCallout {
    
    var isPad: Bool {
        keyboardContext.deviceTypeForKeyboard == .pad
    }

    var isEmojiCallout: Bool {
        calloutActions.first?.isEmojiAction ?? false
    }

    func isSelected(_ offset: Int) -> Bool {
        calloutContext.secondaryActionsIndex == offset
    }
}

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): char
        default: nil
        }
    }
}

#Preview {

    let context1 = CalloutContext()
    let context2 = CalloutContext()

    func previewGroup<ButtonView: View>(
        view: ButtonView,
        context: CalloutContext,
        alignment: HorizontalAlignment
    ) -> some View {
        context.calloutService = .preview
        return view.overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    context.updateSecondaryActions(
                        for: .character("a"),
                        in: geo,
                        alignment: alignment
                    )
                }
            }
        )
        .keyboardActionCalloutContainer(
            calloutContext: context,
            keyboardContext: .preview
        )
    }

    return ZStack {
        Color.red
        VStack(spacing: 100) {
            previewGroup(
                view: Color.blue.frame(width: 40, height: 50),
                context: context1,
                alignment: .leading
            )
            previewGroup(
                view: Color.blue.frame(width: 40, height: 50),
                context: context2,
                alignment: .trailing
            )
        }
    }
    .calloutStyle(.init(
        // callout: .preview2,
        selectedBackgroundColor: .purple
    ))
}
