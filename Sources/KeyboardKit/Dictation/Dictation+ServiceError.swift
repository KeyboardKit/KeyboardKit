//
//  Dictation+ServiceError.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Dictation {

    /// This enum defines dictation service errors.
    ///
    /// These errors can be thrown by a ``DictationService``
    /// or a ``KeyboardDictationService``.
    enum ServiceError: Error {

        /// The service is disabled.
        case disabledService

        /// The service is setup with an invalid deep link.
        case invalidDeepLink(String)

        /// The service hasn't got the proper authorization.
        case invalidDictationAuthorizationStatus(Dictation.AuthorizationStatus)

        /// The current keyboard back navigation host has an invalid URL.
        case invalidKeyboardBackNavigationHostUrl(String)

        /// The service is missing required app information.
        case missingAppInfo

        /// The service is missing a required deep link.
        case missingDictationDeepLink

        /// The service is missing a required keyboard back navigation host.
        case missingKeyboardBackNavigationHost

        /// The service is missing a keyboard configuration.
        case missingKeyboardConfiguration

        /// The service is missing a main app configuration.
        case missingMainAppConfiguration

        /// The service failed to setup a speech recognizer.
        case missingSpeechRecognizer

        /// The service failed to setup a speech request.
        case missingSpeechRecognitionRequest

        /// The service doesn't know how to navigate to the current keyboard back navigation host.
        case unknownKeyboardBackNavigationHost(String)
    }
}
