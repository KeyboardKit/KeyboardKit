//
//  KeyboardFeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to specify what kind of feedback the
 current keyboard should give to the user.
 
 KeyboardKit will create an observable setting instance when
 the keyboard extension is started, then apply this instance
 to ``KeyboardInputViewController/keyboardFeedbackSettings``.
 It will then use this instance by default to determine what
 feedback that should be given for a certain action.
 
 This instance is used by ``StandardKeyboardFeedbackHandler``,
 which means that you can change the basic feedback behavior
 without having to create a custom feedback handler. However,
 more complex changes require a custom feedback handler.
 */
public class KeyboardFeedbackSettings: ObservableObject {
    
    /**
     Create a settings instance.
     
     - Parameters:
       - audioConfiguration: The configuration to use for audio feedback.
       - hapticConfiguration: The configuration to use for haptic feedback.
     */
    public init(
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        hapticConfiguration: HapticFeedbackConfiguration = .standard
    ) {
        self.audioConfiguration = audioConfiguration
        self.hapticConfiguration = hapticConfiguration
    }
    
    /**
     The configuration to use for audio feedback.
     */
    @Published public var audioConfiguration: AudioFeedbackConfiguration
    
    /**
     The configuration to use for haptic feedback.
     */
    @Published public var hapticConfiguration: HapticFeedbackConfiguration
}

public extension KeyboardFeedbackSettings {
    
    /**
     This specifies a standard feedback configuration.
    */
    static let standard = KeyboardFeedbackSettings()
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
        if isAudioFeedbackEnabled {
            disableAudioFeedback()
        } else {
            enableAudioFeedback()
        }
    }

    /**
     Toggle haptic feedback between enabled and disabled.
     */
    func toggleHapticFeedback() {
        if isHapticFeedbackEnabled {
            disableHapticFeedback()
        } else {
            enableHapticFeedback()
        }
    }
}
