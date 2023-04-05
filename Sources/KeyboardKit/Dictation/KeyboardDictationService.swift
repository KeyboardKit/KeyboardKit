//
//  KeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can handle
 dictations between a keyboard extension and its parent app.

 Since keyboard extensions can't access the microphone, your
 keyboard extension must open your app, let your app perform
 dictation and write the text to shared state, then pop back
 to your keyboard to handle the result. This protocol can be
 implemented by classes that supports this type of operation.

 Simply call ``startDictationFromKeyboard(with:)`` from your
 keyboard extension to start a dictation operation. When the
 app opens, just add a `.keyboardDictation(...)` to the root
 view of your app to have it perform the dictation operation
 by calling ``performDictationInApp(with:)``, after which it
 will return to the keyboard, where the controller will call
 ``stopDictationInKeyboard()`` to handle the result.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledKeyboardDictationService``
 set up as a placeholder until a custom one is registered.

 KeyboardKit Pro unlocks a ``StandardDictationService`` plus
 a ``StandardKeyboardDictationService`` when a valid license
 is registered and sets up the keyboard dictation service as
 the main ``KeyboardInputViewController/dictationService``.
 */
public protocol KeyboardDictationService: AnyObject {

    /**
     The current dictation authorization status.
     */
    var authorizationStatus: DictationAuthorizationStatus { get }

    /**
     Request dictation authorization.
     */
    func requestDictationAuthorization() async throws -> DictationAuthorizationStatus

    /**
     Call this function to start dictation from the keyboard,
     where microphone access is unavailable.
     */
    func startDictationFromKeyboard(
        with config: KeyboardDictationConfiguration
    ) async throws

    /**
     Call this function to perform dictation in the main app,
     where microphone access is available.

     This can be 
     */
    func performDictationInApp(
        with config: KeyboardDictationConfiguration
    ) async throws

    /**
     Call this function to abort any ongoing dictation, then
     return to the keyboard extension.
     */
    func abortDictationInApp() async throws

    /**
     Call this function to complete dictation when returning
     to the keyboard extension from the app.

     Since this should be automatically called from an input
     view controller, it doesn't take a configuration. It is
     instead intended to restore itself based on information
     persisted in the keyboard extension.
     */
    func stopDictationInKeyboard() async throws

    /**
     Undo the last performed dictation operation, if any.
     */
    func undoLastDictation()
}
