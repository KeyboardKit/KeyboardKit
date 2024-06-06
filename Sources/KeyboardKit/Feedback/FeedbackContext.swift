//
//  FeedbackContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation

/// This class has observable, feedback-related state.
///
/// This class can be used to configure the audio and haptic
/// feedback that a keyboard should use.
///
/// For instance, you can use the ``audioConfiguration`` and
/// ``hapticConfiguration`` properties to configure feedback,
/// ``isAudioFeedbackEnabled`` and ``isHapticFeedbackEnabled``
/// to toggle feedback on and off. You can also register any
/// custom feedback for any custom action and gesture.
///
/// KeyboardKit will automatically setup an instance of this
/// class in ``KeyboardInputViewController/state``, then use
/// it as global state and inject it as an environment value
/// into the view hierarchy.
public class FeedbackContext: ObservableObject {
    
    /// Create a keyboard configuration instance.
    ///
    /// - Parameters:
    ///   - audio: The audio configuration to use, by deafult `.enabled`.
    ///   - haptic: The haptic configuration to use, by deafult `.minimal`.
    public init(
        audioConfiguration: Feedback.AudioConfiguration = .enabled,
        hapticConfiguration: Feedback.HapticConfiguration = .minimal
    ) {
        self.audioConfiguration = audioConfiguration
        self.hapticConfiguration = hapticConfiguration
        enabledAudioConfiguration = audioConfiguration == .disabled ? .enabled : audioConfiguration
        enabledHapticConfiguration = hapticConfiguration == .disabled ? .enabled : hapticConfiguration
    }
    
    /// The configuration to use for audio feedback.
    @Published
    public var audioConfiguration: Feedback.AudioConfiguration {
        didSet {
            guard audioConfiguration != .disabled else { return }
            enabledAudioConfiguration = audioConfiguration
        }
    }
    
    /// The configuration to use for haptic feedback.
    @Published
    public var hapticConfiguration: Feedback.HapticConfiguration {
        didSet {
            guard hapticConfiguration != .disabled else { return }
            enabledHapticConfiguration = hapticConfiguration
        }
    }
    
    var enabledAudioConfiguration: Feedback.AudioConfiguration
    var enabledHapticConfiguration: Feedback.HapticConfiguration
}

public extension FeedbackContext {
    
    /// This specifies a standard feedback configuration.
    static let standard = FeedbackContext()
}

public extension FeedbackContext {

    /// Get or set whether or not audio feedback is enabled.
    ///
    /// This will toggle between the last used feedback that
    /// isn't ``Feedback/AudioConfiguration/disabled`` and a
    /// purely disabled configuration.
    var isAudioFeedbackEnabled: Bool {
        get { audioConfiguration == enabledAudioConfiguration }
        set { audioConfiguration = newValue ? enabledAudioConfiguration : .disabled }
    }

    /// Get or set whether or not haptic feedback is enabled.
    ///
    /// This will toggle between the last used feedback that
    /// isn't ``Feedback/AudioConfiguration/disabled`` and a
    /// purely disabled configuration.
    var isHapticFeedbackEnabled: Bool {
        get { hapticConfiguration == enabledHapticConfiguration }
        set { hapticConfiguration = newValue ? enabledHapticConfiguration : .disabled }
    }
    
    /// Register custom audio feedback for a certain action.
    func registerCustomFeedback(
        _ feedback: Feedback.AudioConfiguration.CustomFeedback
    ) {
        audioConfiguration.registerCustomFeedback(feedback)
    }
    
    /// Register custom haptic feedback for a certain action.
    func registerCustomFeedback(
        _ feedback: Feedback.HapticConfiguration.CustomFeedback
    ) {
        hapticConfiguration.registerCustomFeedback(feedback)
    }

    /// Toggle audio feedback between enabled and disabled.
    func toggleIsAudioFeedbackEnabled() {
        isAudioFeedbackEnabled.toggle()
    }

    /// Toggle haptic feedback between enabled and disabled.
    func toggleIsHapticFeedbackEnabled() {
        isHapticFeedbackEnabled.toggle()
    }
}

public extension FeedbackContext {

    @available(*, deprecated, renamed: "registerCustomFeedback(_:)")
    func register(
        _ feedback: Feedback.AudioConfiguration.CustomFeedback
    ) {
        registerCustomFeedback(feedback)
    }

    @available(*, deprecated, renamed: "registerCustomFeedback(_:)")
    func register(
        _ feedback: Feedback.HapticConfiguration.CustomFeedback
    ) {
        registerCustomFeedback(feedback)
    }

}
