//
//  Previews+Actions.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension KeyboardActionHandler where Self == KeyboardPreviews.ActionHandler {

    static var preview: KeyboardActionHandler {
        KeyboardPreviews.ActionHandler()
    }
}

public extension KeyboardPreviews {
 
    class ActionHandler: KeyboardActionHandler {
        
        public init() {}
        
        public func canHandle(_ gesture: Keyboard.Gesture, on action: KeyboardAction) -> Bool { false }
        public func handle(_ action: KeyboardAction) {}
        public func handle(_ suggestion: Autocomplete.Suggestion) {}
        public func handle(_ gesture: Keyboard.Gesture, on action: KeyboardAction) {}
        public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
        public func triggerFeedback(for gesture: Keyboard.Gesture, on action: KeyboardAction) {}
        public func triggerAudioFeedback(_ feedback: KeyboardFeedback.Audio) {}
        public func triggerHapticFeedback(_ feedback: KeyboardFeedback.Haptic) {}
    }
}
