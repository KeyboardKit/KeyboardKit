//
//  MockKeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit

class MockKeyboardFeedbackHandler: Mock, KeyboardFeedbackHandler {
    
    lazy var triggerFeedbackRef = MockReference(triggerFeedback)
    lazy var triggerFeedbackWithActionProviderRef = MockReference(triggerFeedbackWithActionProvider)
    
    lazy var triggerAudioFeedbackRef = MockReference(triggerAudioFeedback)
    lazy var triggerHapticFeedbackRef = MockReference(triggerHapticFeedback)
    
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, actionProvider: GestureActionProvider) {
        triggerFeedbackWithActionProvider(for: gesture, on: action)
    }
    
    func triggerFeedbackWithActionProvider(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerFeedbackWithActionProviderRef, args: (gesture, action))
    }
    
    func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerFeedbackRef, args: (gesture, action))
    }
    
    func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerAudioFeedbackRef, args: (gesture, action))
    }
    
    func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        call(triggerHapticFeedbackRef, args: (gesture, action))
    }
}
#endif
