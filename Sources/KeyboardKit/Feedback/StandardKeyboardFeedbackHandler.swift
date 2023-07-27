//
//  StandardKeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This feedback handler is used by default by KeyboardKit and
 can trigger audio and haptic feeeback.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 The provided `settings` instance is used to determine which
 kind of feedback that will be triggered. This means you can
 change feedback behavior at any time.
 
 `v8.0` - This type will be merged with the action handler.
 */
open class StandardKeyboardFeedbackHandler: KeyboardFeedbackHandler {
    
    /**
     Create a standard keyboard feedback handler instance.
     
     - Parameters:
       - settings: The feedback settings to use.
     */
    public init(settings: KeyboardFeedbackSettings) {
        self.settings = settings
    }
    
    /**
     The feedback settings to use.
     */
    public let settings: KeyboardFeedbackSettings
    
    /**
     The audio feedback to use for a certain action gesture.
     */
    open func audioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> AudioFeedback? {
        let config = settings.audioConfiguration
        let custom = config.actions.first { $0.action == action }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return nil }
        if action == .backspace { return config.delete }
        if action.isInputAction { return config.input }
        if action.isSystemAction { return config.system }
        return nil
    }
    
    /**
     The haptic feedback to use for a certain action gesture.
     */
    open func hapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> HapticFeedback? {
        let config = settings.hapticConfiguration
        let custom = config.actions.first { $0.action == action && $0.gesture == gesture }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return config.longPressOnSpace }
        switch gesture {
        case .doubleTap: return config.doubleTap
        case .longPress: return config.longPress
        case .press: return config.press
        case .release: return config.release
        case .repeatPress: return config.repeat
        }
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        triggerAudioFeedback(for: gesture, on: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = audioFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = hapticFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
}
