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
 above the pressed keyboard button.
 */
public struct InputCallout: View {
    
    /**
     Create an input callout view.
     
     - Parameters:
       - context: The context to bind against.
       - keyboardContext: The keyboard context to use for contextual decisions.
       - style: The style to apply to the view, by default `.standard`.
     */
    public init(
        context: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard) {
        self._context = ObservedObject(wrappedValue: context)
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.style = style
    }
    
    @ObservedObject private var context: InputCalloutContext
    @ObservedObject private var keyboardContext: KeyboardContext
    
    private let style: InputCalloutStyle

    static let coordinateSpace = InputCalloutContext.coordinateSpace
    
    public var body: some View {
        VStack(spacing: 0) {
            callout.offset(y: 1)
            button
        }
        .compositingGroup()
        .opacity(context.isActive ? 1 : 0)
        .calloutShadow(style: calloutStyle)
        .position(x: positionX, y: positionY)
    }
}

private extension InputCallout {
    
    var buttonFrame: CGRect {
        context.buttonFrame.insetBy(
            dx: buttonInset.width,
            dy: buttonInset.height)
    }
    
    var buttonInset: CGSize { calloutStyle.buttonInset }
    
    var buttonSize: CGSize { buttonFrame.size }
    
    var calloutSize: CGSize {
        CGSize(
            width: calloutSizeWidth,
            height: calloutSizeHeight)
    }
    
    var calloutSizeHeight: CGFloat {
        let smallSize = buttonSize.height + 20
        return enforceSmallSize ? smallSize : style.calloutSize.height
    }
    
    var calloutSizeWidth: CGFloat {
        let minSize = buttonSize.width + 20
        return max(style.calloutSize.width, minSize)
    }
    
    var calloutStyle: CalloutStyle { style.callout }
    
    var cornerRadius: CGFloat {
        enforceSmallSize ? calloutStyle.buttonCornerRadius : calloutStyle.cornerRadius
    }
    
    var enforceSmallSize: Bool {
        keyboardContext.screenOrientation.isLandscape &&
        keyboardContext.device.isPhone
    }
    
    var positionX: CGFloat {
        buttonFrame.origin.x + buttonSize.width/2
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y + buttonSize.height/2 - calloutSize.height/2
    }
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
    
    static var button: some View {
        Color.red.frame(width: 40, height: 50)
    }
    
    static var previews: some View {
        button.overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    context.updateInput(for: .character("A"), in: geo)
                }
            }
        )
        .inputCallout(
            context: context,
            keyboardContext: .preview,
//            style: .standard)
//            style: .preview1)
            style: .preview2)
    }
}
