//
//  KeyboardAction+StandardActionHandlerSpace.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-02-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardAction.StandardActionHandler {
    
    var isSpaceCursorDragEnabled: Bool {
        keyboardContext.settings.spaceLongPressBehavior == .moveInputCursor
    }

    func isSpaceCursorDrag(_ action: KeyboardAction) -> Bool {
        guard action == .space else { return false }
        let handler = spaceDragGestureHandler
        return handler.currentDragTextPositionOffset != 0
    }

    func tryHandleSpaceDrag(
        on action: KeyboardAction,
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    ) {
        guard action == .space else { return }
        let behavior = keyboardContext.settings.spaceLongPressBehavior
        guard behavior.shouldMoveInputCursor else { return }
        guard keyboardContext.isSpaceDragGestureActive else { return }
        let point = spaceDragGestureStartPoint ?? currentLocation
        spaceDragGestureStartPoint = point
        spaceDragGestureHandler.handleDragGesture(
            from: point,
            to: currentLocation
        )
    }

    func tryUpdateSpaceDragState(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) {
        guard action == .space, isSpaceCursorDragEnabled else { return }
        switch gesture {
        case .press: startSpaceDrag()
        case .longPress: setSpaceDragActive(true)
        case .release, .end: setSpaceDragActive(false)
        default: break
        }
    }
    
    func setSpaceDragActive(_ isActive: Bool) {
        keyboardContext.setIsSpaceDragGestureActive(isActive, animated: true)
    }
    
    func startSpaceDrag() {
        setSpaceDragActive(false)
        spaceDragGestureStartPoint = nil
    }
}
