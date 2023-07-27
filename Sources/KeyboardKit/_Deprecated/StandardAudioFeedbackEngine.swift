//
//  StandardAudioFeedbackEngine.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import AudioToolbox

@available(*, deprecated, renamed: "AudioFeedbackEngine")
open class StandardAudioFeedbackEngine: AudioFeedbackEngine {}
#endif
