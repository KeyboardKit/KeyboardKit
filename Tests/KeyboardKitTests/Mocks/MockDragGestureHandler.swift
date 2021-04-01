//
//  MockDragGestureHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//

import CoreGraphics
import KeyboardKit
import MockingKit

class MockDragGestureHandler: Mock, DragGestureHandler {
    
    lazy var handleDragGestureRef = MockReference(handleDragGesture)
    
    func handleDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        call(handleDragGestureRef, args: (startLocation, currentLocation))
    }
}
