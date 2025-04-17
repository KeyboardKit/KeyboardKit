//
//  GestureButtonState.swift
//  GestureButton
//
//  Created by Daniel Saidi on 2024-09-01.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(watchOS) || os(visionOS)
import SwiftUI

/// This state is used to manage values for a gesture button,
/// without triggering a view update.
class GestureButtonState: ObservableObject {
    
    /// Create a gesture button state value.
    init(
        isPressed: Binding<Bool>? = nil,
        repeatTimer: GestureButtonTimer? = nil
    ) {
        self.isPressedBinding = isPressed ?? .constant(false)
        self.repeatTimer = repeatTimer ?? .init()
    }
    
    let repeatTimer: GestureButtonTimer

    @Published
    var isPressed = false {
        didSet { isPressedBinding.wrappedValue = isPressed }
    }
    
    private(set) var isDragGestureStarted = false
    private(set) var lastDragGestureValue: DragGesture.Value?
    private(set) var lastMaxDragDistance = -1.0
    
    var isPressedBinding: Binding<Bool>
    var isRemoved = false
    var longPressDate = Date()
    var releaseDate = Date()
    var repeatDate = Date()
    
    func startDragGesture(
        with value: DragGesture.Value
    ) {
        isDragGestureStarted = true
        lastMaxDragDistance = -1
        updateDragGesture(with: value)
    }
    
    func stopDragGesture() {
        isDragGestureStarted = false
    }
    
    func updateDragGesture(
        with value: DragGesture.Value
    ) {
        lastDragGestureValue = value
        let distance = distance(
            from: value.startLocation,
            to: value.location
        )
        guard distance > lastMaxDragDistance else { return }
        lastMaxDragDistance = distance
    }
}

extension GestureButtonState {
    
    func distance(
        from point1: CGPoint,
        to point2: CGPoint
    ) -> CGFloat {
        let xDistance = point2.x - point1.x
        let yDistance = point2.y - point1.y
        return sqrt(xDistance * xDistance + yDistance * yDistance)
    }
}

extension GeometryProxy {

    func contains(_ dragEndLocation: CGPoint) -> Bool {
        let x = dragEndLocation.x
        let y = dragEndLocation.y
        guard x > 0, y > 0 else { return false }
        guard x < size.width, y < size.height else { return false }
        return true
    }
}
#endif
