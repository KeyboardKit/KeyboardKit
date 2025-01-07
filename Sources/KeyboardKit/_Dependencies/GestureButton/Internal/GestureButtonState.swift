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
        cancelDelay: TimeInterval? = nil,
        longPressDelay: TimeInterval? = nil,
        doubleTapTimeout: TimeInterval? = nil,
        repeatDelay: TimeInterval? = nil,
        repeatTimer: GestureButtonTimer? = nil
    ) {
        self.isPressedBinding = isPressed ?? .constant(false)
        self.cancelDelay = cancelDelay
        self.longPressDelay = longPressDelay ?? GestureButtonDefaults.longPressDelay
        self.doubleTapTimeout = doubleTapTimeout ?? GestureButtonDefaults.doubleTapTimeout
        self.repeatTimer = repeatTimer ?? .init()
        self.repeatDelay = repeatDelay ?? GestureButtonDefaults.repeatDelay
    }
    
    let cancelDelay: TimeInterval?
    let longPressDelay: TimeInterval
    let doubleTapTimeout: TimeInterval
    let repeatTimer: GestureButtonTimer
    let repeatDelay: TimeInterval

    @Published
    var isPressed = false {
        didSet { isPressedBinding.wrappedValue = isPressed }
    }
    
    var gestureWasStarted = false
    var isPressedBinding: Binding<Bool>
    var isRemoved = false
    var lastGestureValue: DragGesture.Value?
    var longPressDate = Date()
    var releaseDate = Date()
    var repeatDate = Date()
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
