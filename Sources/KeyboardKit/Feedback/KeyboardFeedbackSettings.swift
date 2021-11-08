//
//  KeyboardFeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to specify what kind of feedback the
 current keyboard should give to the user.
 
 Any changes to the view controller's feedback settings will
 automatically apply as long as the view controler still has
 a ``StandardKeyboardFeedbackHandler`` instance that has the
 controller's feedback settings applied.
 */
public class KeyboardFeedbackSettings: ObservableObject {
    
    public init(
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        hapticConfiguration: HapticFeedbackConfiguration = .standard) {
        self.audioConfiguration = audioConfiguration
        self.hapticConfiguration = hapticConfiguration
    }
    
    @Published public var audioConfiguration: AudioFeedbackConfiguration
    @Published public var hapticConfiguration: HapticFeedbackConfiguration
}

public extension KeyboardFeedbackSettings {
    
    /**
     Whether or not the ``audioConfiguration`` is enabled.
     
     The configuration is enabled if it has any other config
     than ``AudioFeedbackConfiguration/noFeedback``.
     */
    var isAudioFeedbackEnabled: Bool {
        audioConfiguration != .noFeedback
    }
    
    /**
     Whether or not the ``hapticConfiguration`` is enabled.
     
     The configuration is enabled if it has any other config
     than ``HapticFeedbackConfiguration/noFeedback``.
     */
    var isHapticFeedbackEnabled: Bool {
        hapticConfiguration != .noFeedback
    }
    
    /**
     Disable audio feedback.
     
     This applies ``AudioFeedbackConfiguration/noFeedback``.
     */
    func disableAudioFeedback() {
        audioConfiguration = .noFeedback
    }
    
    /**
     Disable haptic feedback.
     
     This applies ``HapticFeedbackConfiguration/noFeedback``.
     */
    func disableHapticFeedback() {
        hapticConfiguration = .noFeedback
    }
    
    /**
     Enable audio feedback.
     
     This applies ``AudioFeedbackConfiguration/standard``.
     */
    func enableAudioFeedback() {
        audioConfiguration = .standard
    }
    
    /**
     Enable haptic feedback.
     
     This applies ``HapticFeedbackConfiguration/standard``.
     */
    func enableHapticFeedback() {
        hapticConfiguration = .standard
    }
    
    /**
     Toggle audio feedback between enabled and disabled.
     */
    func toggleAudioFeedback() {
        isAudioFeedbackEnabled ? disableAudioFeedback() : enableAudioFeedback()
    }
    
    /**
     Toggle haptic feedback between enabled and disabled.
     */
    func toggleHapticFeedback() {
        isHapticFeedbackEnabled ? disableHapticFeedback() : enableHapticFeedback()
    }
}
