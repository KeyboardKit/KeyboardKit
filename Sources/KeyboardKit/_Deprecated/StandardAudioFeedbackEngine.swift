//
//  StandardAudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox

/**
 This engine uses system features to trigger audio feedbacks.
 
 It is the default ``AudioFeedback/engine`` on all platforms
 where it's supported.

 You can use, modify and replace the ``shared`` engine. This
 lets you customize the global audio feedback experience.

 Note that the engine is currently only supported on certain
 platforms.
 */
@available(*, deprecated, renamed: "AudioFeedbackEngine")
open class StandardAudioFeedbackEngine: AudioFeedbackEngine {}
#endif
