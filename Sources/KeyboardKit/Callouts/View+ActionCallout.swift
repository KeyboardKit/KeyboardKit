//
//  View+ActionCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /**
     This modifier can be applied to any view that should be
     able to present a ``ActionCallout``.

     - Parameters:
       - calloutContext: The callout context to use.
       - keyboardContext: The keyboard context to use.
       - style: The style to apply to the view, by default ``ActionCalloutStyle/standard``.
       - emojiKeyboardStyle: The emoji keyboard style to use, by default ``EmojiKeyboardStyle/standardPhonePortrait``.
     */
    func actionCallout(
        calloutContext: ActionCalloutContext,
        keyboardContext: KeyboardContext,
        style: ActionCalloutStyle = .standard,
        emojiKeyboardStyle: EmojiKeyboardStyle = .standardPhonePortrait
    ) -> some View {
        ZStack {
            self
            ActionCallout(
                calloutContext: calloutContext,
                keyboardContext: keyboardContext,
                style: style,
                emojiKeyboardStyle: emojiKeyboardStyle
            )
        }.coordinateSpace(name: ActionCalloutContext.coordinateSpace)
    }
}
