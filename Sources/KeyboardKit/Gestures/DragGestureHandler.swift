//
//  KeyboardGesture.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import UIKit

/**
 This protocol can be implemented by classes that can handle
 drag gestures from a start position to a current one.
 */
public protocol DragGestureHandler {
    
    func handleDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint)
}


/**
 This drag gesture handler handles the space key cursor move
 drag gesture.
 */
public class SpaceCursorDragGestureHandler: DragGestureHandler {
    
    public init(
        context: KeyboardContext,
        feedbackHandler: KeyboardFeedbackHandler,
        sensitivity: SpaceDragSensitivity = .medium) {
        self.context = context
        self.feedbackHandler = feedbackHandler
        self.sensitivity = sensitivity
    }
    
    private let context: KeyboardContext
    private let feedbackHandler: KeyboardFeedbackHandler
    
    public let sensitivity: SpaceDragSensitivity
    
    private var currentDragStartLocation: CGPoint?
    private var currentDragTextPositionOffset: Int = 0
    private var textDocumentProxy: UITextDocumentProxy { context.textDocumentProxy }
    
    /**
     Handle a drag gesture on space, which by default should
     move the cursor left and right after a long press.
     */
    public func handleDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        tryStartNewDragGesture(from: startLocation, to: currentLocation)
        let dragDelta = startLocation.x - currentLocation.x
        let textPositionOffset = Int(dragDelta / CGFloat(sensitivity.points))
        guard textPositionOffset != currentDragTextPositionOffset else { return }
        let offsetDelta = textPositionOffset - currentDragTextPositionOffset
        textDocumentProxy.adjustTextPosition(byCharacterOffset: -offsetDelta)
        currentDragTextPositionOffset = textPositionOffset
    }
}

private extension SpaceCursorDragGestureHandler {
    
    func tryStartNewDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        let isNewDrag = currentDragStartLocation != startLocation
        currentDragStartLocation = startLocation
        guard isNewDrag else { return }
        currentDragTextPositionOffset = 0
        feedbackHandler.triggerFeedbackForLongPressOnSpaceDragGesture()
    }
}
