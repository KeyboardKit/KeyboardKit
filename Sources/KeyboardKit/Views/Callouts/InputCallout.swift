//
//  InputCallout.swift
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
     Create an input callout.
     
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
    
    var button: some View {
        CalloutButtonArea(
            frame: buttonFrame,
            style: calloutStyle)
    }
    
    var callout: some View {
        Text(context.input ?? "")
            .font(style.font)
            .frame(minWidth: calloutSize.width, minHeight: calloutSize.height)
            .foregroundColor(calloutStyle.textColor)
            .background(calloutStyle.backgroundColor)
            .cornerRadius(cornerRadius)
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
        let smallSize = buttonSize.height
        return shouldEnforceSmallSize ? smallSize : style.calloutSize.height
    }
    
    var calloutSizeWidth: CGFloat {
        let minSize = buttonSize.width + 2 * style.callout.curveSize.width + style.callout.cornerRadius
        return max(style.calloutSize.width, minSize)
    }
    
    var calloutStyle: CalloutStyle { style.callout }
    
    var cornerRadius: CGFloat {
        shouldEnforceSmallSize ? calloutStyle.buttonCornerRadius : calloutStyle.cornerRadius
    }
    
    var shouldEnforceSmallSize: Bool {
        #if os(iOS)
        keyboardContext.screenOrientation.isLandscape &&
        keyboardContext.device.isPhone
        #elseif os(watchOS)
        return true
        #else
        return false
        #endif
    }
    
    var positionX: CGFloat {
        buttonFrame.origin.x + buttonSize.width/2
    }
    
    var positionY: CGFloat {
        buttonFrame.origin.y + buttonSize.height/2 - calloutSize.height/2
    }
}

struct InputCallout_Previews: PreviewProvider {
    
    static let context1 = InputCalloutContext(isEnabled: true)
    static let context2 = InputCalloutContext(isEnabled: true)
    
    static var button: some View {
        Color.red.frame(width: 40, height: 45)
    }
    
    static var rowItem: some View {
        Color.yellow.frame(width: 46, height: 51)
            .overlay(button)
    }
    
    static var rowItemStyle: InputCalloutStyle {
        var style = InputCalloutStyle.standard
        style.callout.buttonInset = CGSize(width: 3, height: 3)
        return style
    }
    
    static var previews: some View {
        VStack {
            
            // Button
            button.overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        context1.updateInput(for: .character("a"), in: geo)
                    }
                }
            ).inputCallout(
                context: context1,
                keyboardContext: .preview,
                style: .standard)
            //  style: .preview1)
            //  style: .preview2)
            
            
            // Row Item
            
            rowItem.overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        context2.updateInput(for: .character("a"), in: geo)
                    }
                }
            ).inputCallout(
                context: context2,
                keyboardContext: .preview,
                style: rowItemStyle)
            //  style: .preview1)
            //  style: .preview2)
            
        }
    }
}
