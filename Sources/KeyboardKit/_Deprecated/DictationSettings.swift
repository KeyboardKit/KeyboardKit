//
//  DictationSettings.swift
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
public class DictationSettings: ObservableObject {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "dictation")

    @AppStorage("\(prefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit = 5.0 {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()

    @AppStorage("\(prefix)lastSynced", store: .keyboardSettings)
    var lastSynced = Keyboard.StorageValue(Date().addingTimeInterval(-3600))
}

extension DictationSettings {

    func syncToContextIfNeeded(
        _ context: DictationContext
    ) {
        guard lastSynced.value < lastChanged else { return }
        context.sync(with: self)
        lastSynced.value = Date()
    }
}

private extension DictationSettings {

    func triggerChange() {
        lastChanged = Date()
    }
}
