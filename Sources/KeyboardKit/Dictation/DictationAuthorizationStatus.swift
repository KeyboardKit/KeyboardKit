//
//  DictationAuthorizationStatus.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

/**
 This enum defines dictation authorization statuses that are
 mapped from underlying frameworks that are not available on
 all supported platforms.
 */
enum DictationAuthorizationStatus: Int {

    case disabledService = -1
    case notDetermined = 0
    case denied = 1
    case restricted = 2
    case authorized = 3
}

#if os(iOS)
import Speech

extension SFSpeechRecognizerAuthorizationStatus {

    /// Get a dictation-mapped status.
    var dictationStatus: DictationAuthorizationStatus {
        switch self {
        case .notDetermined: return .notDetermined
        case .denied: return .denied
        case .restricted: return .restricted
        case .authorized: return .authorized
        @unknown default: return .notDetermined
        }
    }
}
#endif
