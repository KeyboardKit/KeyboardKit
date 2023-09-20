//
//  Dictation+ServiceError.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Dictation {
    
    /**
     This enum defines service errors, that can be thrown by
     a ``DictationService`` or ``KeyboardDictationService``.
     */
    enum ServiceError: Error {
        
        /// The dictation service is disabled.
        case disabledService
        
        /// The service is setup with an invalid deep link.
        case invalidAppDeepLink(String)
        
        /// The service hasn't got the proper authorization.
        case invalidDictationAuthorizationStatus(Dictation.AuthorizationStatus)
        
        /// The service is setup without an App Group ID.
        case missingAppGroupId
        
        /// The service failed to setup a speech recognizer.
        case missingSpeechRecognizer
        
        /// The service failed to setup a speech request.
        case missingSpeechRecognitionRequest
    }
}
