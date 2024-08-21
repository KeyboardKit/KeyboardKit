//
//  DictationSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// DEPRECATED!
///
/// > Warning: Settings have been moved to the context. This
/// type will be removed in KeyboardKit 9.0.
public class DictationSettings: ObservableObject, LegacySettings {

    static let prefix = KeyboardSettings.storeKeyPrefix(for: "dictation")

    @AppStorage("\(prefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit = 5.0 {
        didSet { triggerChange() }
    }

    @Published
    var lastChanged = Date()
}

extension DictationSettings {

    func syncToContextIfNeeded(
        _ context: DictationContext
    ) {
        guard shouldSyncToContext else { return }
        context.sync(with: self)
        updateLastSynced()
    }
}
