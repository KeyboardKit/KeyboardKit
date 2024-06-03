//
//  FeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This observable class can be used to manage settings for
/// the ``Feedback`` namespace.
public class FeedbackSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "feedback")

    @AppStorage("\(prefix)isAudioFeedbackEnabled", store: .keyboardSettings)
    var isAudioFeedbackEnabled = true

    @AppStorage("\(prefix)isHapticFeedbackEnabled", store: .keyboardSettings)
    var isHapticFeedbackEnabled = false
}
