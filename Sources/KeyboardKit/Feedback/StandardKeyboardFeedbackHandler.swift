//
//  StandardKeyboardFeedbackHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This standard keyboard feedback handler is used by standard
 by KeyboardKit and can be used to trigger standard feeeback
 when a user performs gestures on keyboard actions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 The provided `settings` instance is used to determine which
 kind of feedback that will be triggered. This means you can
 change feedback behavior at any time.
 */
open class StandardKeyboardFeedbackHandler: KeyboardFeedbackHandler {
    
    /**
     Create a standard keyboard feedback handler instance.
     */
    public init(settings: KeyboardFeedbackSettings) {
        self.settings = settings
    }
    
    
    public let settings: KeyboardFeedbackSettings
    
    public var audioConfig: AudioFeedbackConfiguration { settings.audioConfiguration }
    public var hapticConfig: HapticFeedbackConfiguration { settings.hapticConfiguration }
    
    
    /**
     Whether or not a feedback should be given for a certain
     gesture on a certain action, given the provided gesture
     action provider.
     
     By default, the function will return `true` for a press
     on a gesture that has a tap action or if the gesture is
     not a tap and the action has an action for that gesture.
     */
    open func shouldTriggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, actionProvider: GestureActionProvider) -> Bool {
        if gesture == .press && actionProvider(.tap, action) != nil { return true }
        if gesture != .tap && actionProvider(gesture, action) != nil { return true }
        return false
    }
    
    /**
     Try to trigger user feedback for a certain gesture on a
     certain action, given a certain gesture action provider.
     
     By default, the function checks `shouldGiveFeedback` to
     determine if any feedback should be given. It will then
     call `triggerAudioFeedback` and `triggerHapticFeedback`.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, actionProvider: GestureActionProvider) {
        guard shouldTriggerFeedback(for: gesture, on: action, actionProvider: actionProvider) else { return }
        triggerFeedback(for: gesture, on: action)
    }
    
    /**
     Try to trigger user feedback for a certain gesture on a
     certain action, given a certain gesture action provider.
     
     By default, the function checks `shouldGiveFeedback` to
     determine if any feedback should be given. It will then
     call `triggerAudioFeedback` and `triggerHapticFeedback`.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        triggerAudioFeedback(for: gesture, on: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    /**
     Trigger feedback for when space is pressed so long that
     it enters cursor drag state.
     */
    open func triggerFeedbackForLongPressOnSpaceDragGesture() {
        hapticConfig.longPressOnSpace.trigger()
    }
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        if action == .backspace { return audioConfig.delete.play() }
        if action.isInputAction { return audioConfig.input.play() }
        if action.isSystemAction { return audioConfig.system.play() }
    }
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     */
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        switch gesture {
        case .doubleTap: hapticConfig.doubleTap.trigger()
        case .longPress: hapticConfig.longPress.trigger()
        case .press: hapticConfig.tap.trigger()
        case .release: hapticConfig.tap.trigger()
        case .repeatPress: hapticConfig.repeat.trigger()
        case .tap: hapticConfig.tap.trigger()
        }
    }
}
