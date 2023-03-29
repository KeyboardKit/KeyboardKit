//
//  ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This action callout view can be used to present a secondary
 action collection for a keyboard action.
 */
public struct ActionCallout: View {
    
    /**
     Create an action callout.
     
     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply to the view, by default ``KeyboardActionCalloutStyle/standard``.
       - emojiKeyboardStyle: The emoji keyboard style to use, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
     */
    public init(
        calloutContext: ActionCalloutContext,
        keyboardContext: KeyboardContext,
        style: KeyboardActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) {
        self._calloutContext = ObservedObject(wrappedValue: calloutContext)
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.style = style
        self.emojiKeyboardStyle = emojiKeyboardStyle
    }
    
    @ObservedObject
    private var calloutContext: ActionCalloutContext

    @ObservedObject
    private var keyboardContext: KeyboardContext
    
    private let style: KeyboardActionCalloutStyle
    private let emojiKeyboardStyle: EmojiKeyboardStyle
    
    public var body: some View {
        Button(action: calloutContext.reset) {
            VStack(alignment: calloutContext.alignment, spacing: 0) {
                callout
                buttonArea
            }
        }
        .buttonStyle(ActionCalloutButtonStyle())
        .font(style.font.font)
        .compositingGroup()
        .opacity(calloutContext.isActive ? 1 : 0)
        .keyboardCalloutShadow(style: calloutStyle)
        .position(x: positionX, y: positionY)
        .offset(y: style.verticalOffset)
    }
}

private struct ActionCalloutButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}


// MARK: - Private Properties

private extension ActionCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { isEmojiCallout ? buttonFrameForEmojis : buttonFrameForCharacters }
    var buttonFrameForCharacters: CGRect { calloutContext.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonFrameForEmojis: CGRect { calloutContext.buttonFrame }
    var buttonInset: CGSize { calloutStyle.buttonInset }
    var calloutActions: [KeyboardAction] { calloutContext.actions }
    var calloutButtonSize: CGSize { buttonFrame.size.limited(to: style.maxButtonSize) }
    var calloutStyle: KeyboardCalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGSize { calloutStyle.curveSize }
    var isLeading: Bool { calloutContext.isLeading }
    var isTrailing: Bool { calloutContext.isTrailing }
    
    var buttonArea: some View {
        CalloutButtonArea(frame: buttonFrame, style: calloutStyle)
            .opacity(isPad ? 0 : 1)
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutActions.enumerated()), id: \.offset) {
                calloutView(for: $0.element)
                    .frame(width: calloutButtonSize.width, height: calloutButtonSize.height)
                    .background(isSelected($0.offset) ? style.selectedBackgroundColor : .clear)
                    .foregroundColor(isSelected($0.offset) ? style.selectedForegroundColor : style.callout.textColor)
                    .cornerRadius(cornerRadius)
                    .padding(.vertical, style.verticalTextPadding)
            }
        }
        .padding(.horizontal, curveSize.width)
        .background(calloutBackground)
    }
    
    var calloutBackground: some View {
        CustomRoundedRectangle(
            topLeft: cornerRadius,
            topRight: cornerRadius,
            bottomLeft: !isPad && isLeading ? 2 : cornerRadius,
            bottomRight: !isPad && isTrailing ? 2 : cornerRadius)
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
        EmojiKeyboardItem(
            emoji: emoji,
            style: .standard(for: keyboardContext)
        )
    }
    
    var positionX: CGFloat {
        let buttonWidth = calloutButtonSize.width
        let adjustment = (CGFloat(calloutActions.count) * buttonWidth)/2
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.verticalTextPadding
    }
}


// MARK: - Private Functions

private extension ActionCallout {
    
    var isPad: Bool { keyboardContext.deviceType == .pad }

    var isEmojiCallout: Bool {
        calloutActions.first?.isEmojiAction ?? false
    }

    func isSelected(_ offset: Int) -> Bool {
        calloutContext.selectedIndex == offset
    }
}

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): return char
        default: return nil
        }
    }
}

struct ActionCallout_Previews: PreviewProvider {

    static let actionHandler = PreviewKeyboardActionHandler()

    static let actionProvider = PreviewCalloutActionProvider()

    static let keyboardContext = KeyboardContext.preview

    static let actionContext1 = ActionCalloutContext(
        actionHandler: actionHandler,
        actionProvider: actionProvider)

    static let actionContext2 = ActionCalloutContext(
        actionHandler: actionHandler,
        actionProvider: actionProvider)

    static func previewGroup<ButtonView: View>(
        view: ButtonView,
        actionContext: ActionCalloutContext,
        alignment: HorizontalAlignment
    ) -> some View {
        view.overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    actionContext.updateInputs(
                        for: .character("S"),
                        in: geo,
                        alignment: alignment
                    )
                }
            }
        )
        .keyboardActionCallout(
            calloutContext: actionContext,
            keyboardContext: keyboardContext,
            style: .standard,
            emojiKeyboardStyle: .standard(for: keyboardContext))
    }
    
    static var previews: some View {
        VStack {
            previewGroup(
                view: Color.red.frame(width: 40, height: 50),
                actionContext: actionContext1,
                alignment: .leading)
            previewGroup(
                view: Color.yellow.frame(width: 40, height: 50),
                actionContext: actionContext2,
                alignment: .trailing)
        }
    }
}
