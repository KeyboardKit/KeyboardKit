//
//  KeyboardDictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// perform dictation from a keyboard extension.
///
/// Since keyboard extensions can't access the microphone, a
/// keyboard dictation service must (unless it finds another
/// way not yet discovered) open its app and start dictation,
/// write the dictated result to shared state, then navigate
/// back to the keyboard and handle the result.
///
/// KeyboardKit doesn't have a standard dictation service as
/// it has for other services. Instead, a disabled dictation
/// service will be used until you setup KeyboardKit Pro, or
/// register a custom service.
///
/// See <doc:Dictation-Article> for more information.
///
/// > Note: The two dictation service types will probably be
/// merged in KeyboardKit 9.0.
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
