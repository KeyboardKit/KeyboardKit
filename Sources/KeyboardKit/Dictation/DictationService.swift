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

 This protocol doesn't work in a keyboard extension, since a
 keyboard extension can't access the microphone. You can use
 a``KeyboardDictationService`` to bypass this limitation and
 perform dictation from a keyboard extension.

 Simply call ``startDictation(with:)`` to start dictating in
 a way specified by the service, then call ``stopDictation()``
 to stop the operation. Since dictation may stop at any time,
 for instance by a period of silence, services must describe
 how to access the result when the operation is stopped by a
 service or another part of the system.

 Services should call ``requestDictationAuthorization()`` to
 request the required permissions before stating a dictation
 operation, but you can call it beforehand as well, to avoid
 interrupting the first dictation operation.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledDictationService`` which
 you can use as a placeholder until you have a real one.

 KeyboardKit Pro unlocks a ``StandardDictationService`` when
 a valid license is registered.
 */
public protocol DictationService: AnyObject {

    /**
     The current dictation authorization status.
     */
    var authorizationStatus: DictationAuthorizationStatus { get }

    
    /**
     Request dictation authorization.
     */
    func requestDictationAuthorization() async throws -> DictationAuthorizationStatus

    /**
     Reset any previously set dictation result.
     */
    func resetDictationResult() async throws

    /**
     Start dictating with the provided configuration.
     */
    func startDictation(
        with config: DictationConfiguration
    ) async throws

    /**
     Stop dictating.
     */
    func stopDictation() async throws
}
