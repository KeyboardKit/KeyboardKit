//
//  DictationSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-10-27.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This type provides dictation-related settings.
///
/// All properties for this type are automatically stored in
/// ``KeyboardSettings/store`` with a `dictation` prefix.
public struct DictationSettings: Sendable {

    /// Create a custom settings instance.
    public init() {}

    /// The settings key prefix to use for the namespace.
    public static var settingsPrefix: String {
        KeyboardSettings.storeKeyPrefix(for: "dictation")
    }
    
    
    // MARK: - Persisted Properties

    /// The max number of seconds of silence, after which dictation automatically ends.
    @AppStorage("\(settingsPrefix)silenceLimit", store: .keyboardSettings)
    public var silenceLimit: TimeInterval = 5.0
    
    
    // MARK: - Internal State
    
    @AppStorage("\(settingsPrefix)dictatedText", store: .keyboardSettings)
    var dictatedText = ""

    @AppStorage("\(settingsPrefix)hostApplicationBundleId", store: .keyboardSettings)
    var hostApplicationBundleId: String?

    @AppStorage("\(settingsPrefix)isDictationStartedByKeyboard", store: .keyboardSettings)
    var isDictationStartedByKeyboard = false
}
