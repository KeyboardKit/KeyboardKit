//
//  DisabledDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This disabled service can be used as a placeholder when you
 don't have access to a real dictation service.

 The service will not perform any dictation and throw errors
 whenever you try.
 */
class DisabledDictationService: DictationService {}

extension DisabledDictationService {

    /// The current authorization status.
    var authorizationStatus: DictationAuthorizationStatus { .disabledService }

    /// Whether or not the service is dictating.
    var isDictating: Bool { false }

    /**
     Ask the user to authorize the app for dictation.

     This must only be called from the main app and not from
     the keyboard, since a keyboard extensions cannot access
     the microphone.
     */
    func authorizeDictation() async -> DictationAuthorizationStatus {
        .disabledService
    }

    /**
     Start dictating.
     */
    func startDictating() throws {
        throw DictationServiceError.disabledService
    }

    /**
     Stop dictating.
     */
    func stopDictating() throws {
        throw DictationServiceError.disabledService
    }

    /**
     Toggle dictation on and off.
     */
    func toggleDictation() throws {
        throw DictationServiceError.disabledService
    }
}
