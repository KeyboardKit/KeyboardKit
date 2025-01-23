//
//  MockDragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//

import CoreGraphics
import MockingKit
@testable import KeyboardKit

class MockSpaceDragGestureHandler: Gestures.SpaceDragGestureHandler, Mockable {

    var mock = Mock()
    
    lazy var handleDragGestureRef = MockReference(handleDragGesture)
    
    override func handleDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        call(handleDragGestureRef, args: (startLocation, currentLocation))
    }
}
