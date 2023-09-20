//
//  Dictation+AuthorizationStatus.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

public extension Dictation {
    
    /**
     This enum maps platform-specific dictation status types
     to multi-platform values.
     */
    enum AuthorizationStatus: Int {
        
        case disabledService = -1
        case notDetermined = 0
        case denied = 1
        case restricted = 2
        case authorized = 3
    }
}

#if os(iOS)
import Speech
 
public extension SFSpeechRecognizerAuthorizationStatus {

    /// Get a dictation-mapped status.
    var keyboardDictationStatus: Dictation.AuthorizationStatus {
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
