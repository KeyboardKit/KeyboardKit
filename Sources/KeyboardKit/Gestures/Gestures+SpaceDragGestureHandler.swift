//
//  Gestures+SpaceDragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension DragGestureHandler where Self == Gestures.SpaceDragGestureHandler {

    /// Create a ``Gestures/SpaceDragGestureHandler``.
    ///
    /// - Parameters:
    ///   - sensitivity: The drag sensitivity, by default `.medium`.
    ///   - verticalThreshold: The vertical threshold in points, by default `50`.
    ///   - action: The action to perform when the offset changes.
    static func spaceDrag(
        sensitivity: Keyboard.SpaceDragSensitivity? = nil,
        verticalThreshold: Double? = nil,
        action: @escaping (Int) -> Void
    ) -> Self {
        Gestures.SpaceDragGestureHandler(
            sensitivity: sensitivity,
            verticalThreshold: verticalThreshold,
            action: action
        )
    }
}

public extension Gestures {
    
    /// This custom gesture handler can handle the space key
    /// gesture that moves the input cursor.
    ///
    /// KeyboardKit will create an instance of the class and
    /// inject it into ``KeyboardInputViewController/state``.
    ///
    /// This service can also be resolved with the shorthand
    /// ``DragGestureHandler/spaceDrag(sensitivity:verticalThreshold:action:)``.
    class SpaceDragGestureHandler: DragGestureHandler {
        
        /// Create a space drag gesture handler instance.
        ///
        /// - Parameters:
        ///   - sensitivity: The drag sensitivity, by default `.medium`.
        ///   - verticalThreshold: The vertical threshold in points, by default `50`.
        ///   - action: The action to perform when the offset changes.
        public init(
            sensitivity: Keyboard.SpaceDragSensitivity? = nil,
            verticalThreshold: Double? = nil,
            action: @escaping (Int) -> Void
        ) {
            self.sensitivity = sensitivity ?? .medium
            self.verticalThreshold = verticalThreshold ?? 50
            self.action = action
        }
        
        
        /// The drag sensitivity.
        public var sensitivity: Keyboard.SpaceDragSensitivity
        
        /// The vertical threshold in points.
        public var verticalThreshold: Double
        
        /// The action to perform when the offset changes.
        public var action: (Int) -> Void
        
        
        /// The location where the current drag stated.
        public var currentDragStartLocation: CGPoint?
        
        /// The currently applied drag text position offset.
        public var currentDragTextPositionOffset: Int = 0
        
        /// Handle a drag gesture on space, which by default
        /// should activate after a long press.
        public func handleDragGesture(
            from startLocation: CGPoint,
            to currentLocation: CGPoint
        ) {
            tryStartNewDragGesture(from: startLocation, to: currentLocation)
            let dragDelta = startLocation.x - currentLocation.x
            let textPositionOffset = Int(dragDelta / CGFloat(sensitivity.points))
            guard textPositionOffset != currentDragTextPositionOffset else { return }
            let offsetDelta = textPositionOffset - currentDragTextPositionOffset
            currentDragTextPositionOffset = textPositionOffset
            let verticalDistance = abs(startLocation.y - currentLocation.y)
            guard verticalDistance < verticalThreshold else { return }
            action(-offsetDelta)
        }
    }
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

extension UITextDocumentProxy {

    /// This drag offset is used when the gesture moves over
    /// a combined emoji.
    func spaceDragOffset(for rawOffset: Int) -> Int? {
        let multiplier = spaceDragOffsetMultiplier(for: rawOffset)
        return rawOffset * (multiplier ?? 1)
    }

    /// This offset muliplier is used when the gesture moves
    /// over a combined emoji.
    func spaceDragOffsetMultiplier(for offset: Int) -> Int? {
        let char = spaceDragOffsetMultiplierCharacter(for: offset)
        return char?.spaceDragOffsetMultiplier
    }

    /// This character is used when the gesture moves over a
    /// combined emoji.
    func spaceDragOffsetMultiplierCharacter(for offset: Int) -> String.Element? {
        switch offset {
        case 1: documentContextAfterInput?.first
        case -1: documentContextBeforeInput?.last
        default: nil
        }
    }
}
#endif

extension String.Element {

    /// This offset muliplier is used when the gesture moves
    /// over a combined emoji.
    var spaceDragOffsetMultiplier: Int {
        guard isEmoji else { return 1 }
        return Int(floor(Double(utf8.count)/2))
    }
}

private extension Gestures.SpaceDragGestureHandler {

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
