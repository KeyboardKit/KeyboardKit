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
       - style: The style to apply to the view, by default `.standard`.
     */
    public init(
        context: ActionCalloutContext,
        style: ActionCalloutStyle = .standard) {
        self._context = ObservedObject(wrappedValue: context)
        self.style = style
    }
    
    @ObservedObject private var context: ActionCalloutContext
    
    private let style: ActionCalloutStyle
    
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
    }
}


// MARK: - Private Properties

private extension ActionCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonInset: CGSize { calloutStyle.buttonInset }
    var calloutButtonSize: CGSize { buttonFrame.size.limited(to: style.maxButtonSize) }
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
                    .frame(calloutButtonSize)
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
            bottomLeft: isLeading ? 2 : cornerRadius,
            bottomRight: isTrailing ? 2 : cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var positionX: CGFloat {
        let buttonWidth = calloutButtonSize.width
        let adjustment = (CGFloat(calloutInputs.count) * buttonWidth)/2
        let signedAdjustment = isTrailing ? -adjustment + buttonWidth : adjustment
        return buttonFrame.origin.x + signedAdjustment
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y - style.verticalTextPadding
    }
}


// MARK: - Private Functions

private extension ActionCallout {
    
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
    
    static let context1 = ActionCalloutContext(
        actionHandler: .preview,
        actionProvider: PreviewCalloutActionProvider())
    
    static let context2 = ActionCalloutContext(
        actionHandler: .preview,
        actionProvider: PreviewCalloutActionProvider())
    
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
                style: .standard)
            
            
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
                style: rowItemStyle)
        }
    }
}
