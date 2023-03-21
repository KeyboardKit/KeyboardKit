//
//  DictationServiceError.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum defines various errors that can be throw when you
 are using a ``DictationService``.
 */
enum DictationServiceError: Error {

    /// The dictation service is disabled.
    case disabledService

    /// The service is not authorized to perform dictation.
    case invalidDictationAuthorizationStatus(DictationAuthorizationStatus)

    /// The service failed to setup a speech recognizer.
    case missingSpeechRecognizer

    /// The service failed to setup a speech recogniztion request.
    case missingSpeechRecognitionRequest
}
