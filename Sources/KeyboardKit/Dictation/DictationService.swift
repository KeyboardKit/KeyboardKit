//
//  DictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any classes that can be
 used to perform dictation, e.g. using the device microphone.

 This service doesn't work in keyboard extensions, since the
 extension layer can't access the microphone. Make sure that
 you use a ``KeyboardDictationService`` to perform dictation
 from a keyboard extension.

 To start dictation, just call ``startDictation(with:)``. It
 should set up the audio engine and perform dictation. Since
 dictation may stop at any time, a service must describe how
 to access the result after the operation completes. To stop
 dictation, just call ``stopDictation()``.

 Services should call ``requestDictationAuthorization()`` to
 request the required permissions before stating a dictation.
 
 KeyboardKit doesn't have a standard service, as it does for
 other services. You must either implement a service, or use
 KeyboardKit Pro, which will automatically unlock a standard
 service when a Gold license key is registered.
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
