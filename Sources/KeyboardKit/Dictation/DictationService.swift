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

 This protocol will not work in keyboard extensions, since a
 keyboard extension must perform different operations due to
 the lack of microphone access. For these cases, you can use
 a ``KeyboardDictationService`` instead.

 Simply call ``startDictating(with:)`` to start dictating in
 a way specified by the service, then call ``stopDictating()``
 to stop the operation. Since dictation may stop at any time,
 for instance by a period of silence, services must describe
 how to access the result when dictation ends by the service.

 Services should call ``requestDictationAuthorization()`` to
 request the required permissions before stating a dictation
 operation, but you can call it beforehand as well, to avoid
 interrupting the first dictation attempt.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledDictationService`` which
 you can use as a placeholder until you have a real one.

 KeyboardKit Pro unlocks a ``StandardDictationService`` when
 a valid license is registered.
 */
public protocol DictationService: AnyObject {

    /**
     The current authorization status.
     */
    var authorizationStatus: DictationAuthorizationStatus { get }

    /**
     Whether or not the service is currently dictating.
     */
    var isDictating: Bool { get }

    /**
     Request dictation authorization.
     */
    func requestDictationAuthorization() async -> DictationAuthorizationStatus

    /**
     Reset any previously set dictation result.
     */
    func resetDictationResult() async throws

    /**
     Start dictating with the provided configuration.
     */
    func startDictating(with config: DictationConfiguration) async throws

    /**
     Stop dictating.
     */
    func stopDictating() async throws
}
