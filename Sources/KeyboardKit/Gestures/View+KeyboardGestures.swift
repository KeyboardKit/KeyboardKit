//
//  View+KeyboardGestures.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-21.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    typealias KeyboardGestureAction = () -> Void
    typealias KeyboardDragGestureAction = (_ startLocation: CGPoint, _ location: CGPoint) -> Void
    
    /**
     Add keyboard-specific gesture actions to the view.
     
     Some implicit built-in logic requires a provided action
     to work, like updating callout contexts, but all action
     blocks will be triggered correctly.
     */
    func keyboardGestures(
        action: KeyboardAction? = nil,
        tapAction: KeyboardGestureAction? = nil,
        doubleTapAction: KeyboardGestureAction? = nil,
        longPressAction: KeyboardGestureAction? = nil,
        repeatAction: KeyboardGestureAction? = nil,
        dragAction: KeyboardDragGestureAction? = nil,
        inputCalloutContext: InputCalloutContext = .shared,
        secondaryInputCalloutContext: SecondaryInputCalloutContext = .shared) -> some View {
        KeyboardGestures(
            view: self,
            action: action,
            tapAction: tapAction,
            doubleTapAction: doubleTapAction,
            longPressAction: longPressAction,
            repeatAction: repeatAction,
            dragAction: dragAction,
            inputCalloutContext: inputCalloutContext,
            secondaryInputCalloutContext: secondaryInputCalloutContext)
    }
}
