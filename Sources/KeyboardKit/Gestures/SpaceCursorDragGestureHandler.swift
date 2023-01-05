//
//  SpaceCursorDragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import CoreGraphics

/**
 This drag gesture handler handles the space key cursor move
 drag gesture.
 */
open class SpaceCursorDragGestureHandler: DragGestureHandler {

    @available(*, deprecated, message: "Use the keyboardContext initializer instead.")
    public init(
        context: KeyboardContext,
        feedbackHandler: KeyboardFeedbackHandler,
        sensitivity: SpaceDragSensitivity = .medium
    ) {
        self.keyboardContext = context
        self.feedbackHandler = feedbackHandler
        self.sensitivity = sensitivity
    }

    /**
     Create a handler space cursor drag gesture handler.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - feedbackHandler: The feedback handler to use.
       - sensitivity: The drag sensitivity, by default ``SpaceDragSensitivity/medium``.
     */
    public init(
        keyboardContext: KeyboardContext,
        feedbackHandler: KeyboardFeedbackHandler,
        sensitivity: SpaceDragSensitivity = .medium
    ) {
        self.keyboardContext = keyboardContext
        self.feedbackHandler = feedbackHandler
        self.sensitivity = sensitivity
    }

    public let keyboardContext: KeyboardContext
    public let feedbackHandler: KeyboardFeedbackHandler
    public let sensitivity: SpaceDragSensitivity

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
        keyboardContext.textDocumentProxy.adjustTextPosition(byCharacterOffset: -offsetDelta)
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
#endif
