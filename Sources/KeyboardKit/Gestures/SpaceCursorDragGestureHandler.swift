//
//  SpaceCursorDragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This drag gesture handler handles the space key cursor move
 drag gesture.
 */
open class SpaceCursorDragGestureHandler: DragGestureHandler {

    /**
     Create a handler space cursor drag gesture handler.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - feedbackHandler: The feedback handler to use.
       - sensitivity: The drag sensitivity, by default ``SpaceDragSensitivity/medium``.
       - action: The action to perform for the drag offset.
     */
    public init(
        keyboardContext: KeyboardContext,
        feedbackHandler: KeyboardFeedbackHandler,
        sensitivity: SpaceDragSensitivity = .medium,
        action: @escaping (Int) -> Void
    ) {
        self.keyboardContext = keyboardContext
        self.feedbackHandler = feedbackHandler
        self.sensitivity = sensitivity
        self.action = action
    }

    public let keyboardContext: KeyboardContext
    public let feedbackHandler: KeyboardFeedbackHandler
    public let sensitivity: SpaceDragSensitivity
    public let action: (Int) -> Void

    public var currentDragStartLocation: CGPoint?
    public var currentDragTextPositionOffset: Int = 0

    /**
     Handle a drag gesture on space, which by default should
     move the cursor left and right after a long press.
     */
    public func handleDragGesture(
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    ) {
        tryStartNewDragGesture(from: startLocation, to: currentLocation)
        let dragDelta = startLocation.x - currentLocation.x
        let textPositionOffset = Int(dragDelta / CGFloat(sensitivity.points))
        guard textPositionOffset != currentDragTextPositionOffset else { return }
        let offsetDelta = textPositionOffset - currentDragTextPositionOffset
        action(-offsetDelta)
        currentDragTextPositionOffset = textPositionOffset
    }
}

private extension SpaceCursorDragGestureHandler {

    func tryStartNewDragGesture(
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    ) {
        let isNewDrag = currentDragStartLocation != startLocation
        currentDragStartLocation = startLocation
        guard isNewDrag else { return }
        currentDragTextPositionOffset = 0
    }
}
