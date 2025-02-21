//
//  KeyboardFeedbackService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-08-11.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to trigger audio and haptic feedback.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the feedback behavior.
public protocol KeyboardFeedbackService: AnyObject {

    /// Trigger the provided audio feedback.
    func triggerAudioFeedback(_ feedback: KeyboardFeedback.Audio)

    /// Trigger the provided haptic feedback.
    func triggerHapticFeedback(_ feedback: KeyboardFeedback.Haptic)
}
