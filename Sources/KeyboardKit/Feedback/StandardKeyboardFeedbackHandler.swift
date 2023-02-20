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
     The audio configuration to use, derived from ``settings``.
     */
    public var audioConfig: AudioFeedbackConfiguration { settings.audioConfiguration }
    
    /**
     The haptic configuration to use, derived from ``settings``.
     */
    public var hapticConfig: HapticFeedbackConfiguration { settings.hapticConfiguration }
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     
     You can override this function to customize the default
     feedback behavior.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        triggerAudioFeedback(for: gesture, on: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     
     You can override this function to customize the default
     audio feedback behavior.
     */
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let custom = audioConfig.actions.first { $0.action == action }
        if let custom = custom { return custom.feedback.trigger() }
        if action == .space && gesture == .longPress { return }
        if action == .backspace { return audioConfig.delete.trigger() }
        if action.isInputAction { return audioConfig.input.trigger() }
        if action.isSystemAction { return audioConfig.system.trigger() }
    }
    
    /**
     Trigger feedback for when a `gesture` is performed on a
     certain `action`.
     
     You can override this function to customize the default
     haptic feedback behavior.
     */
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let custom = hapticConfig.actions.first { $0.action == action && $0.gesture == gesture }
        if let custom = custom { return custom.feedback.trigger() }
        if action == .space && gesture == .longPress { return hapticConfig.longPressOnSpace.trigger() }
        switch gesture {
        case .doubleTap: hapticConfig.doubleTap.trigger()
        case .longPress: hapticConfig.longPress.trigger()
        case .press: hapticConfig.tap.trigger()
        case .release: hapticConfig.tap.trigger()
        case .repeatPress: hapticConfig.repeat.trigger()
        }
    }
}
