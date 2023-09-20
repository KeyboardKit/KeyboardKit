//
//  Callouts+InputCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Callouts {
    /**
     This callout can be used to show the currently typed action
     above the pressed keyboard button.
     */
    struct InputCallout: View {
        
        /**
         Create an input callout.
         
         - Parameters:
           - calloutContext: The callout context to use.
           - keyboardContext: The keyboard context to use.
           - style: The style to apply to the view, by default ``KeyboardStyle/InputCallout/standard``.
         */
        public init(
            calloutContext: Context,
            keyboardContext: KeyboardContext,
            style: Style = .standard
        ) {
            self._calloutContext = ObservedObject(wrappedValue: calloutContext)
            self._keyboardContext = ObservedObject(wrappedValue: keyboardContext)
            self.style = style
        }
        
        public typealias Context = CalloutInputContext
        public typealias Style = KeyboardStyle.InputCallout
        
        static let coordinateSpace = Context.coordinateSpace
        
        @ObservedObject
        private var calloutContext: Context
        
        @ObservedObject
        private var keyboardContext: KeyboardContext
        
        private let style: Style
        
        public var body: some View {
            callout
                .transition(.opacity)
                .opacity(calloutContext.isActive ? 1 : 0)
                .keyboardCalloutShadow(style: style.callout)
                .position(position)
                .allowsHitTesting(false)
        }
    }
}

private extension Callouts.InputCallout {

    var callout: some View {
        VStack(spacing: 0) {
            calloutBubble.offset(y: 1)
            calloutButton
        }
        .compositingGroup()
    }

    var calloutBubble: some View {
        Text(calloutContext.input ?? "")
            .font(style.font.font)
            .frame(minWidth: calloutSize.width, minHeight: calloutSize.height)
            .foregroundColor(style.callout.textColor)
            .background(style.callout.backgroundColor)
            .cornerRadius(cornerRadius)
    }
    
    var calloutButton: some View {
        Callouts.ButtonArea(
            frame: buttonFrame,
            style: style.callout
        )
    }
}

private extension Callouts.InputCallout {
    
    var buttonFrame: CGRect {
        calloutContext.buttonFrame.insetBy(
            dx: buttonInset.width,
            dy: buttonInset.height)
    }
    
    var buttonInset: CGSize {
        style.callout.buttonInset
    }
    
    var buttonSize: CGSize {
        buttonFrame.size
    }
    
    var calloutSize: CGSize {
        CGSize(
            width: calloutSizeWidth,
            height: calloutSizeHeight
        )
    }
    
    var calloutSizeHeight: CGFloat {
        let smallSize = buttonSize.height
        return shouldEnforceSmallSize ? smallSize : style.calloutSize.height
    }
    
    var calloutSizeWidth: CGFloat {
        let minSize = buttonSize.width + 2 * style.callout.curveSize.width + style.callout.cornerRadius
        return max(style.calloutSize.width, minSize)
    }
    
    var cornerRadius: CGFloat {
        shouldEnforceSmallSize ? style.callout.buttonCornerRadius : style.callout.cornerRadius
    }
}

private extension Callouts.InputCallout {

    var shouldEnforceSmallSize: Bool {
        keyboardContext.deviceType == .phone && keyboardContext.interfaceOrientation.isLandscape
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

#if os(iOS) || os(macOS) || os(watchOS)
struct Callouts_InputCallout_Previews: PreviewProvider {

    struct Preview: View {

        var style: KeyboardStyle.InputCallout {
            var style = KeyboardStyle.InputCallout.standard
            style.callout.backgroundColor = .blue
            style.callout.textColor = .white
            style.callout.buttonInset = CGSize(width: 3, height: 3)
            return style
        }

        @StateObject
        var context = CalloutInputContext(isEnabled: true)

        func button(for context: CalloutInputContext) -> some View {
            GeometryReader { geo in
                GestureButton(
                    pressAction: { showCallout(for: geo) },
                    endAction: context.resetWithDelay,
                    label: { _ in Color.red.cornerRadius(5) }
                )
            }
            .frame(width: 15, height: 15)
            .padding()
            .background(Color.yellow.cornerRadius(6))
        }

        func showCallout(for geo: GeometryProxy) {
            context.updateInput(for: .character("a"), in: geo)
        }

        var buttonStack: some View {
            HStack {
                button(for: context)
                button(for: context)
                button(for: context)
            }
        }

        var body: some View {
            VStack {
                buttonStack
                buttonStack
                Button("Reset") {
                    context.reset()
                }
            }
            .keyboardInputCalloutContainer(
                calloutContext: context,
                keyboardContext: .preview
            )
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
