//
//  SecondaryInputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This callout can be used to show the currently typed action
 above the pressed keyboard button. It supports `.character`
 actions and will ignore any other actions.
 */
public struct InputCallout: View {
    
    public init(
        context: InputCalloutContext,
        style: InputCalloutStyle) {
        self.context = context
        self.style = style
    }
    
    @ObservedObject private var context: InputCalloutContext
    
    private let style: InputCalloutStyle
    
    static let coordinateSpace = InputCalloutContext.coordinateSpace
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            buttonArea
            callout
        }
        .position(x: positionX, y: positionY)
        .compositingGroup()
        .shadow(color: calloutStyle.borderColor, radius: 0.4)
        .shadow(color: calloutStyle.shadowColor, radius: calloutStyle.shadowRadius)
        .opacity(context.isActive ? 1 : 0)
    }
}

private extension InputCallout {
    
    var backgroundColor: Color { calloutStyle.backgroundColor }
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    var buttonInset: CGSize { calloutStyle.buttonOverlayInset }
    var buttonSize: CGSize { buttonFrame.size }
    var calloutSize: CGSize { style.calloutSize }
    var calloutStyle: CalloutStyle { style.callout }
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
    var curveSize: CGFloat { calloutStyle.curveSize }
    
    var buttonArea: some View {
        HStack(alignment: .top, spacing: 0) {
            calloutCurve.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            buttonAreaText
            calloutCurve
        }
    }
    
    var buttonAreaText: some View {
        Text("")
            .frame(buttonSize)
            .background(buttonAreaBackground)
    }
    
    var buttonAreaBackground: some View {
        CustomRoundedRectangle(bottomLeft: cornerRadius, bottomRight: cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var callout: some View {
        Text(context.input ?? "")
            .font(style.font)
            .frame(width: buttonSize.width + calloutSize.width, height: calloutSize.height)
            .background(calloutBackground)
            .offset(y: -buttonSize.height)
    }
    
    var calloutBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(backgroundColor)
    }
    
    var calloutCurve: some View {
        CalloutCurve()
            .frame(width: curveSize, height: curveSize)
            .foregroundColor(backgroundColor)
            .offset(y: -1)
    }
    
    var positionX: CGFloat {
        buttonFrame.origin.x + buttonSize.width/2
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y + buttonSize.height - calloutSize.height/2
    }
}
