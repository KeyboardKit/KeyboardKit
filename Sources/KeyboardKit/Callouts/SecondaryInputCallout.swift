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
 for akeyboard actions. It only supports `character` actions
 and will ignore any other actions.
 
 `TODO` This callout bubble currently breaks when wide chars
 are added to it. We should fix this in a later update.
 */
public struct SecondaryInputCallout: View {
    
    public init(style: SecondaryInputCalloutStyle) {
        self.style = style
    }
    
    @EnvironmentObject private var context: SecondaryInputCalloutContext
    
    private let style: SecondaryInputCalloutStyle
    
    public var body: some View {
        VStack(alignment: context.alignment.horizontal, spacing: 0) {
            callout
            buttonArea
        }
        .font(style.font)
        .compositingGroup()
        .position(x: positionX, y: positionY)
        .shadow(color: calloutStyle.borderColor, radius: 0.4)
        .shadow(color: calloutStyle.shadowColor, radius: calloutStyle.shadowRadius)
        .opacity(context.isActive ? 1 : 0)
        .onTapGesture(perform: context.reset)
    }
}


// MARK: - Private Properties

private extension SecondaryInputCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonInset: CGSize { calloutStyle.buttonOverlayInset }
    var buttonSize: CGSize { buttonFrame.size }
    var calloutInputs: [String] { context.actions.compactMap { $0.input } }
    var calloutStyle: CalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGFloat { calloutStyle.curveSize }
    var isLeading: Bool { context.isLeading }
    var isTrailing: Bool { context.isTrailing }
    var verticalPaddingAdjustment: CGFloat { 2 * style.verticalPadding }
    
    var buttonArea: some View {
        HStack(alignment: .top, spacing: 0) {
            calloutCurveLeading
            buttonAreaText
            calloutCurveTrailing
        }
    }
    
    var buttonAreaBackground: some View {
        CustomRoundedRectangle(bottomLeft: cornerRadius, bottomRight: cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var buttonAreaText: some View {
        Text("")
            .frame(buttonSize)
            .background(buttonAreaBackground)
    }
    
    var callout: some View {
        HStack(spacing: 0) {
            calloutEdge
            calloutBody
            calloutEdge.rotationEffect(.degrees(180))
        }
    }
    
    var calloutBody: some View {
        HStack(spacing: 0) {
            ForEach(Array(calloutInputs.enumerated()), id: \.offset) {
                Text($0.element)
                    .frame(buttonSize)
                    .background(isSelected($0.offset) ? style.selectedBackgroundColor : .clear)
                    .foregroundColor(isSelected($0.offset) ? style.selectedTextColor : style.textColor)
                    .cornerRadius(cornerRadius)
                    .padding(.vertical, style.verticalPadding)
            }
        }.background(backgroundColor)
    }
    
    var calloutCurve: some View {
        CalloutCurve()
            .frame(width: curveSize, height: curveSize)
            .foregroundColor(backgroundColor)
    }
    
    var calloutCurveLeading: some View {
        calloutCurve
            .rotationEffect(.degrees(90))
            .offset(y: isLeading ? -1 : 0)
    }
    
    var calloutCurveTrailing: some View {
        calloutCurve
            .offset(y: isTrailing ? -1 : 0)
    }
    
    var calloutEdge: some View {
        CustomRoundedRectangle(topLeft: cornerRadius, bottomLeft: cornerRadius)
            .frame(width: curveSize, height: buttonSize.height + 2 * style.verticalPadding)
            .foregroundColor(backgroundColor)
    }
    
    var positionX: CGFloat {
        let buttonWidth = buttonSize.width
        let adjustment = (CGFloat(calloutInputs.count) * buttonWidth)/2
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.verticalPadding
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
