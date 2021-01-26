//
//  View+KeyboardAction.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Apply gestures for a certain keyboard action, using the
     provided action handler.
     */
    @ViewBuilder
    func keyboardAction(
        _ action: KeyboardAction,
        actionHandler: KeyboardActionHandler) -> some View {
        if action == .nextKeyboard {
            self
        } else {
            self.keyboardGestures(
                action: action,
                tapAction: { actionHandler.handle(.tap, on: action) },
                doubleTapAction: { actionHandler.handle(.doubleTap, on: action) },
                longPressAction: { actionHandler.handle(.longPress, on: action) },
                repeatAction: { actionHandler.handle(.repeatPress, on: action) },
                dragAction: { start, current in actionHandler.handleDrag(on: action, from: start, to: current) })
        }
    }
}
