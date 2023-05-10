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
 keyboard must open your app, start dictation, write text to
 shared state, then return to the keyboard and handle it.

 To start dictation from a keyboard extension, just call the
 ``startDictationFromKeyboard(with:)`` function using an app
 specific configuration. You can also setup dictation before
 using ``DictationContext/setup(with:)`` then simply trigger
 the ``KeyboardAction/dictation`` to let your action handler
 call the start function.

 To start dictation from the main app, just use the same app
 specific configuration and add the `.keyboardDictation(...)`
 view modifier to the app root view. This will make your app
 automatically handle dictation when it's opened with a deep
 link that corresponds to the configuration.

 The rest of the process will be automated and uses standard
 ways to handle the result when returnung to the keyboard.

 KeyboardKit does not have a standard service as it does for
 other services. It has a ``DisabledKeyboardDictationService``
 that you can use a placeholder.

 KeyboardKit Pro unlocks a ``StandardDictationService`` plus
 a ``StandardKeyboardDictationService`` when a valid license
 is registered and sets up the standard dictation service as
 the ``KeyboardInputViewController/dictationService``.
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
     */
    func stopDictationInKeyboard() async throws

    /**
     Undo the last performed dictation operation, if any.
     */
    func undoLastDictation()
}
