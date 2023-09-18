//
//  View+KeyboardButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-24.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /**
     Apply keyboard button style and gestures to the view.

     - Parameters:
       - action: The keyboard action to trigger.
       - style: The keyboard style to apply.
       - actionHandler: The keyboard action handler to use.
       - calloutContext: The callout context to affect, if any.
       - isPressed: An optional binding that can be used to observe the button pressed state.
       - isInScrollView: Whether or not the gestures are used in a scroll view, by default `false`.
       - releaseOutsideTolerance: The percentage of the button size that should span outside the button bounds and still count as a release, by default `0.75`.
     */
    func keyboardButton(
        for action: KeyboardAction,
        style: KeyboardStyle.Button,
        actionHandler: KeyboardActionHandler,
        calloutContext: CalloutContext?,
        isPressed: Binding<Bool> = .constant(false),
        isInScrollView: Bool = false,
        releaseOutsideTolerance: Double = 1
    ) -> some View {
        self
            .keyboardButtonStyle(
                style,
                isPressed: isPressed.wrappedValue
            )
            .keyboardButtonGestures(
                for: action,
                actionHandler: actionHandler,
                calloutContext: calloutContext,
                isPressed: isPressed,
                isInScrollView: isInScrollView,
                releaseOutsideTolerance: releaseOutsideTolerance
            )
    }
}

struct View_KeyboardButton_Previews: PreviewProvider {
    
    struct Preview: View {
        
        @State
        var isPressed = false
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Is pressed: \(isPressed.description)")
                button(for: Text("a"), style: .preview1)
                button(for: Text("A"), style: .preview2)
                button(for: Image.keyboardGlobe, style: .preview1)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .environment(\.sizeCategory, .extraExtraLarge)
        }
        
        func button<Content: View>(
            for content: Content,
            style: KeyboardStyle.Button
        ) -> some View {
            content
                .padding()
                .keyboardButton(
                    for: .backspace,
                    style: style,
                    actionHandler: .preview,
                    calloutContext: .preview,
                    isPressed: $isPressed
                )
        }
    }

    static var previews: some View {
        Preview()
    }
}
