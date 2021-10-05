//
//  SecondaryInputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This callout can be used to present secondary input actions
 for a keyboard actions.
 */
public struct SecondaryInputCallout: View {
    
    /**
     Create a secondary input callout view.
     
     - Parameters:
       - context: The context to bind against.
       - style: The style to apply to the view, by default `.standard`.
     */
    public init(
        context: SecondaryInputCalloutContext,
        style: SecondaryInputCalloutStyle = .standard) {
        self._context = ObservedObject(wrappedValue: context)
        self.style = style
    }
    
    @ObservedObject private var context: SecondaryInputCalloutContext
    
    private let style: SecondaryInputCalloutStyle
    
    public var body: some View {
        VStack(alignment: context.alignment, spacing: 0) {
            callout
            buttonArea
        }
        .font(style.font)
        .compositingGroup()
        .opacity(context.isActive ? 1 : 0)
        .calloutShadow(style: calloutStyle)
        .onTapGesture(perform: context.reset)
        .position(x: positionX, y: positionY)
    }
}


// MARK: - Private Properties

private extension SecondaryInputCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonInset: CGSize { calloutStyle.buttonInset }
    var buttonSize: CGSize { buttonFrame.size }
    var calloutInputs: [String] { context.actions.compactMap { $0.input } }
    var calloutStyle: CalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGSize { calloutStyle.curveSize }
    var isLeading: Bool { context.isLeading }
    var isTrailing: Bool { context.isTrailing }
    
    var buttonArea: some View {
        CalloutButtonArea(frame: buttonFrame, style: calloutStyle)
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutInputs.enumerated()), id: \.offset) {
                Text($0.element)
                    .frame(buttonSize)
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
            bottomLeft: isLeading ? 4 : cornerRadius,
            bottomRight: isTrailing ? 2 : cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var positionX: CGFloat {
        let buttonWidth = buttonSize.width
        let adjustment = (CGFloat(calloutInputs.count) * buttonWidth)/2
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.verticalTextPadding
    }
}


// MARK: - Private Functions

private extension SecondaryInputCallout {
    
    func isSelected(_ offset: Int) -> Bool {
        context.selectedIndex == offset
    }
}


// MARK: - Private Extensions

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): return char
        default: return nil
        }
    }
}

struct SecondaryInputCallout_Previews: PreviewProvider {
    
    static let context = SecondaryInputCalloutContext(
        actionHandler: .preview,
        actionProvider: PreviewSecondaryCalloutActionProvider())
    
    static var button: some View {
        Color.red.frame(width: 40, height: 50)
    }
    
    static var previews: some View {
        VStack {
            button.overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        context.updateInputs(
                            for: .character("S"),
                            in: geo,
                            alignment: .trailing
                        )
                    }
                }
            )
        }
        .secondaryInputCallout(context: context, style: .standard)
        // .inputCallout(context: context, style: .preview1)
        // .inputCallout(context: context, style: .preview2)
    }
}
