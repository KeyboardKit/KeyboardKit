//
//  FeedbackContext+Sync.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension FeedbackContext {

    /// Sync the context with the provided settings.
    func sync(with settings: FeedbackSettings) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: settings)
        }
    }
}

extension FeedbackContext {

    /// Perform a settings sync after an async delay.
    func syncAfterAsync(with settings: FeedbackSettings) {
        let audio = settings.isAudioFeedbackEnabled
        let haptic = settings.isHapticFeedbackEnabled
        if isAudioFeedbackEnabled != audio {
            isAudioFeedbackEnabled = audio
        }
        if isHapticFeedbackEnabled != haptic {
            isHapticFeedbackEnabled = haptic
        }
    }
}
