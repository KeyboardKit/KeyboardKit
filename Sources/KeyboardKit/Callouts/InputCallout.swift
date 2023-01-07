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
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply to the view, by default `.standard`.
     */
    public init(
        calloutContext: InputCalloutContext,
        keyboardContext: KeyboardContext,
        style: InputCalloutStyle = .standard
    ) {
        self._calloutContext = ObservedObject(wrappedValue: calloutContext)
        self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
        self.style = style
    }

    @ObservedObject
    private var calloutContext: InputCalloutContext

    @ObservedObject
    private var keyboardContext: KeyboardContext

    private let style: InputCalloutStyle

    static let coordinateSpace = InputCalloutContext.coordinateSpace
    
    public var body: some View {
        callout
            .transition(.opacity)
            .opacity(calloutContext.isActive ? 1 : 0)
            .keyboardCalloutShadow(style: calloutStyle)
            .position(position)
            .allowsHitTesting(false)
    }
}

private extension InputCallout {

    var callout: some View {
        VStack(spacing: 0) {
            calloutBubble.offset(y: 1)
            calloutButton
        }
        .compositingGroup()
    }

    var calloutBubble: some View {
        Text(calloutContext.input ?? "")
            .font(style.font)
            .frame(minWidth: calloutSize.width, minHeight: calloutSize.height)
            .foregroundColor(calloutStyle.textColor)
            .background(calloutStyle.backgroundColor)
            .cornerRadius(cornerRadius)
    }
    
    var calloutButton: some View {
        CalloutButtonArea(
            frame: buttonFrame,
            style: calloutStyle)
    }
}


// MARK: - Private View Properties

private extension InputCallout {
    
    var buttonFrame: CGRect {
        calloutContext.buttonFrame.insetBy(
            dx: buttonInset.width,
            dy: buttonInset.height)
    }
    
    var buttonInset: CGSize {
        calloutStyle.buttonInset
    }
    
    var buttonSize: CGSize {
        buttonFrame.size
    }
    
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
}


// MARK: - Private Functionality

private extension InputCallout {

    var shouldEnforceSmallSize: Bool {
        #if os(iOS)
        keyboardContext.interfaceOrientation.isLandscape && keyboardContext.deviceType == .phone
        #elseif os(watchOS)
        return true
        #else
        return false
        #endif
    }

    var position: CGPoint {
        CGPoint(x: positionX, y: positionY)
    }

    var positionX: CGFloat {
        buttonFrame.origin.x + buttonSize.width/2
    }

    var positionY: CGFloat {
        let base = buttonFrame.origin.y + buttonSize.height/2 - calloutSize.height/2
        let isEmoji = calloutContext.action?.isEmojiAction == true
        if isEmoji { return base + 5 }
        return base
    }
}


// MARK: - Previews

struct InputCallout_Previews: PreviewProvider {
    
    struct Preview: View {

        var style: InputCalloutStyle {
            var style = InputCalloutStyle.standard
            style.callout.backgroundColor = .blue
            style.callout.textColor = .white
            style.callout.buttonInset = CGSize(width: 3, height: 3)
            return style
        }

        @StateObject
        var context = InputCalloutContext(isEnabled: true)

        func button(for context: InputCalloutContext) -> some View {
            GeometryReader { geo in
                Button(
                    action: { showCallout(for: geo) },
                    label: { Color.red.cornerRadius(5) }
                )
            }
            .frame(width: 40, height: 45)
            .padding()
            .background(Color.yellow.cornerRadius(6))
        }

        func showCallout(for geo: GeometryProxy) {
            context.updateInput(for: .character("a"), in: geo)
            context.resetWithDelay()
        }

        var body: some View {
            VStack {
                HStack {
                    button(for: context)
                    button(for: context)
                    button(for: context)
                }
                Button("Reset") {
                    context.reset()
                }
            }
            .keyboardInputCallout(
                calloutContext: context,
                keyboardContext: .preview
            )
        }
    }

    static var previews: some View {
        Preview()
    }
}
