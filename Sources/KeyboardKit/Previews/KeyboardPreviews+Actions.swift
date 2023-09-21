//
//  KeyboardPreviews+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension KeyboardActionHandler where Self == KeyboardPreviews.ActionHandler {
    
    /// This handler can be used in SwiftUI previews.
    static var preview: KeyboardActionHandler { KeyboardPreviews.ActionHandler() }
}

public extension KeyboardPreviews {
 
    /// This action handler can be used in SwiftUI previews.
    class ActionHandler: KeyboardActionHandler {
        
        public init() {}
        
        public func canHandle(_ gesture: Gesture, on action: KeyboardAction) -> Bool { false }
        public func handle(_ action: KeyboardAction) {}
        public func handle(_ gesture: Gesture, on action: KeyboardAction) {}
        public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
        public func triggerFeedback(for gesture: Gesture, on action: KeyboardAction) {}
    }
}
