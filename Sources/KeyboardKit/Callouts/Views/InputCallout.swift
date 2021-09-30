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
    
    public init(style: InputCalloutStyle) {
        self.style = style
    }
    
    @EnvironmentObject private var context: InputCalloutContext
    
    private let style: InputCalloutStyle
    
    static let coordinateSpace = InputCalloutContext.coordinateSpace
    
    public var body: some View {
        VStack(spacing: 0) {
            callout.offset(y: 1)
            button
        }
        .compositingGroup()
        .calloutShadow(style: calloutStyle)
        .opacity(context.isActive ? 1 : 0)
        .offset(y: -calloutSize.height/2)
    }
}

private extension InputCallout {
    
    var buttonFrame: CGRect { context.buttonFrame.insetBy(dx: buttonInset.width, dy: buttonInset.height) }
    
    var buttonInset: CGSize { calloutStyle.buttonOverlayInset }
    
    var buttonSize: CGSize { buttonFrame.size }
    
    var calloutSize: CGSize { style.calloutSize }
    
    var calloutStyle: CalloutStyle { style.callout }
    
    var cornerRadius: CGFloat { calloutStyle.cornerRadius }
}

private extension InputCallout {
    
    var button: some View {
        CalloutButtonArea(
            frame: buttonFrame,
            style: calloutStyle)
    }
    
    var callout: some View {
        Text(context.input ?? "")
            .font(style.font)
            .frame(width: calloutSize.width, height: calloutSize.height)
            .foregroundColor(calloutStyle.textColor)
            .background(calloutStyle.backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

struct InputCallout_Previews: PreviewProvider {
    
    static let context = InputCalloutContext(isEnabled: true)
    
    static var previews: some View {
        VStack {
            Color.red.frame(width: 40, height: 50)
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                context.updateInput(for: .character("A"), in: geo)
                            }
                    }
                )
            
        }
        .inputCallout(style: .standard)
        .environmentObject(context)
    }
}
