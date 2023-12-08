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

 KeyboardKit doesn't have a standard service, as it does for
 other services. You must either implement a service, or use
 KeyboardKit Pro, which will automatically unlock a standard
 service when a Gold license key is registered.
 */
public protocol KeyboardDictationService: AnyObject {

    /// The current dictation authorization status.
    var authorizationStatus: Dictation.AuthorizationStatus { get }
    
    /// A list of supported locales.
    var supportedLocales: [KeyboardLocale] { get }

    
    /// Request dictation authorization.
    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus

    /// Start a dictation operation from the keyboard.
    func startDictationFromKeyboard(
        with config: Dictation.KeyboardConfiguration
    ) async throws

    /// Perform a dictation operation in the main app.
    func performDictationInApp(
        with config: Dictation.KeyboardConfiguration
    ) async throws

    /// Abort an active dictation operation in the main app.
    func abortDictationInApp() async throws

    /// Finish an active dictation operation in the main app.
    func finishDictationInApp() async throws

    /// Handle any dictation result in the keyboard.
    func handleDictationResultInKeyboard() async throws

    /// Undo the last performed dictation operation, if any.
    func undoLastDictation()
}
