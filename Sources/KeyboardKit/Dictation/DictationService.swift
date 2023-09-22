//
//  DictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by classes that can handle
 dictation, e.g. by using the device microphone.

 This service doesn't work in keyboard extensions, since the
 extension layer can't access the microphone. Keyboards must
 instead use a ``KeyboardDictationService`` for dictation.

 To start dictation, ``startDictation(with:)`` should set up
 the audio engine and perform dictation. Since dictation may
 stop at any time, e.g. by silence, a service implementation
 must describe how you can access the dictation result. Call
 ``stopDictation()`` to stop dictation.

 Services should call ``requestDictationAuthorization()`` to
 request the required permissions before stating a dictation.
 
 KeyboardKit doesn't have a standard service, as it does for
 other services. You must either implement a service, or use
 KeyboardKit Pro, which will automatically unlock a standard
 dictation service when a Gold license key is registered.
 */
public protocol DictationService: AnyObject {

    /// The current dictation authorization status.
    var authorizationStatus: Dictation.AuthorizationStatus { get }


    /// Request dictation authorization.
    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus

    /// Reset any previously set dictation result.
    func resetDictationResult() async throws

    /// Start dictating with the provided configuration.
    func startDictation(with config: Dictation.Configuration) async throws

    /// Stop dictating.
    func stopDictation() async throws
}
