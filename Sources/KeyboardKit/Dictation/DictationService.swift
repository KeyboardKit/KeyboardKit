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
 dictation operations.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledDictationService`` which
 can be used as a placeholder.

 KeyboardKit Pro unlocks a ``StandardDictationService`` that
 is then used by a ``StandardKeyboardDictationService`` that
 is also unlocked by KeyboardKit Pro. Make sure that you use
 a ``KeyboardDictationService`` to handle dictations between
 keyboard extensions and their main app.
 */
protocol DictationService: AnyObject {

    /// The current authorization status.
    var authorizationStatus: DictationAuthorizationStatus { get }

    /// Whether or not the service is dictating.
    var isDictating: Bool { get }

    /**
     Ask the user to authorize the app for dictation.

     This must only be called from the main app and not from
     the keyboard, since a keyboard extensions cannot access
     the microphone.
     */
    func authorizeDictation() async -> DictationAuthorizationStatus

    /**
     Start dictating.
     */
    func startDictating() throws

    /**
     Stop dictating.
     */
    func stopDictating() throws

    /**
     Toggle dictation on and off.
     */
    func toggleDictation() throws
}
