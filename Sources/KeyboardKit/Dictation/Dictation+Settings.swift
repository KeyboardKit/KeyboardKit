//
//  Dictation+Settings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension Dictation {

    /// This type is used for dictation-related settings.
    ///
    /// All properties in this type are automatically stored
    /// in ``Foundation/UserDefaults/keyboardSettings`` with
    /// a `dictation` prefix.
    struct Settings {

        /// Create a custom settings instance.
        public init() {}

        /// The settings key prefix to use for the namespace.
        public static var settingsPrefix: String {
            Keyboard.Settings.storeKeyPrefix(for: "dictation")
        }

        /// The max number of seconds of silence after which
        /// the dictation operation automatically finishes.
        @AppStorage("\(settingsPrefix)silenceLimit", store: .keyboardSettings)
        public var silenceLimit: TimeInterval = 5.0
    }
}
