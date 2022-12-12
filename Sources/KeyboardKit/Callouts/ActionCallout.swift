//
//  ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This callout can be used to present alternate actions for a
 keyboard certain keyboard action.
 */
public struct ActionCallout: View {
    
    /**
     Create an action callout.
     
     - Parameters:
       - context: The context to bind against.
       - device: The device type to use, by default ``DeviceType/current``.
       - style: The style to apply to the view, by default ``ActionCalloutStyle/standard``.
       - emojiKeyboardStyle: The emoji keyboard style to use, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
     */
    public init(
        context: ActionCalloutContext,
        device: DeviceType = .current,
        style: ActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) {
        self._context = ObservedObject(wrappedValue: context)
        self.device = device
        self.style = style
        self.emojiKeyboardStyle = emojiKeyboardStyle
    }
    
    @ObservedObject
    private var context: ActionCalloutContext

    private var keyboardContext: KeyboardContext {
        #if os(iOS) || os(tvOS)
        KeyboardInputViewController.shared.keyboardContext
        #else
        return KeyboardContext()
        #endif
    }
    
    private let device: DeviceType
    private let style: ActionCalloutStyle
    private let emojiKeyboardStyle: EmojiKeyboardStyle
    
    public var body: some View {
        VStack(alignment: context.alignment, spacing: 0) {
            callout
            buttonArea
        }
        .font(style.font)
        .compositingGroup()
        .opacity(context.isActive ? 1 : 0)
        .calloutShadow(style: calloutStyle)
        #if os(iOS) || os(macOS) || os(watchOS)
        .onTapGesture(perform: context.reset)
        #endif
        .position(x: positionX, y: positionY)
        .offset(y: style.verticalOffset)
    }
}


// MARK: - Private Properties

private extension ActionCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { isEmojiCallout ? buttonFrameForEmojis : buttonFrameForCharacters }
    var buttonFrameForCharacters: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonFrameForEmojis: CGRect { context.buttonFrame }
    var buttonInset: CGSize { calloutStyle.buttonInset }
    var calloutActions: [KeyboardAction] { context.actions }
    var calloutButtonSize: CGSize { buttonFrame.size.limited(to: style.maxButtonSize) }
    var calloutStyle: CalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGSize { calloutStyle.curveSize }
    var isLeading: Bool { context.isLeading }
    var isTrailing: Bool { context.isTrailing }
    
    var buttonArea: some View {
        CalloutButtonArea(frame: buttonFrame, style: calloutStyle)
            .opacity(isPad ? 0 : 1)
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutActions.enumerated()), id: \.offset) {
                calloutView(for: $0.element)
                    .frame(size: calloutButtonSize)
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
    
    var isPad: Bool { device == .pad }

    var isEmojiCallout: Bool {
        calloutActions.first?.isEmojiAction ?? false
    }

    func isSelected(_ offset: Int) -> Bool {
        context.selectedIndex == offset
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
    
    static let context1 = ActionCalloutContext(
        actionHandler: actionHandler,
        actionProvider: actionProvider)
    
    static let context2 = ActionCalloutContext(
        actionHandler: actionHandler,
        actionProvider: actionProvider)
    
    static var button: some View {
        Color.red.frame(width: 40, height: 50)
    }
    
    static var rowItem: some View {
        Color.yellow.frame(width: 46, height: 56)
            .overlay(button)
    }
    
    static var rowItemStyle: ActionCalloutStyle {
        var style = ActionCalloutStyle.standard
        style.callout.buttonInset = CGSize(width: 3, height: 3)
        return style
    }
    
    static var previews: some View {
        VStack {
            
            // Button
            
            button.overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        context1.updateInputs(
                            for: .character("S"),
                            in: geo,
                            alignment: .leading
                        )
                    }
                }
            ).actionCallout(
                context: context1,
                style: .standard,
                emojiKeyboardStyle: .standard(for: keyboardContext)
            )
        
            
            // Row Item
            
            rowItem.overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        context2.updateInputs(
                            for: .character("S"),
                            in: geo,
                            alignment: .trailing
                        )
                    }
                }
            ).actionCallout(
                context: context2,
                style: rowItemStyle,
                emojiKeyboardStyle: .standard(for: keyboardContext)
            )
        }
    }
}
