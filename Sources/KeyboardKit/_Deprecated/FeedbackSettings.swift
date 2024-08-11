//
//  FeedbackSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// DEPRECATED!
///
/// > Warning: Settings have been moved to the context. This
/// type will be removed in KeyboardKit 9.0.
public class FeedbackSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "feedback")

    @AppStorage("\(prefix)isAudioFeedbackEnabled", store: .keyboardSettings)
    var isAudioFeedbackEnabled = true

    @AppStorage("\(prefix)isHapticFeedbackEnabled", store: .keyboardSettings)
    var isHapticFeedbackEnabled = false

    @Published
    var lastChanged = Date()

    @AppStorage("\(prefix)lastSynced", store: .keyboardSettings)
    var lastSynced = Keyboard.StorageValue(Date().addingTimeInterval(-3600))
}

extension FeedbackSettings {

    func syncToContextIfNeeded(
        _ context: FeedbackContext
    ) {
        guard lastSynced.value < lastChanged else { return }
        context.sync(with: self)
        lastSynced.value = Date()
    }
}

private extension FeedbackSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}
