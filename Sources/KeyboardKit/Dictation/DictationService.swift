//
//  DictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// perform dictation from a keyboard extension or in an app.
///
/// Since keyboard extensions can't access the microphone, a
/// dictation service must open the main app to let it start
/// dictation, write the dictation results to a shared state,
/// then navigate back to the keyboard and handle the result.
///
/// KeyboardKit doesn't have a standard dictation service as
/// it has for other services. Instead, a disabled dictation
/// service will be used until you setup KeyboardKit Pro, or
/// register a custom service.
///
/// See <doc:Dictation-Article> for more information.
public protocol DictationService: AnyObject {

    /// The current dictation authorization status.
    var authorizationStatus: Dictation.AuthorizationStatus { get }

    /// A list of supported locales.
    var supportedLocales: [Locale] { get }


    /// Request dictation authorization.
    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus

    /// Start a dictation operation from the keyboard.
    func startDictationFromKeyboard() async throws

    /// Start a dictation operation in the main app.
    func startDictationInApp() async throws

    /// Abort an active dictation operation in the main app.
    func abortDictationInApp() async throws

    /// Finish an active dictation operation in the main app.
    func finishDictationInApp() async throws

    /// Try to return to the keyboard from the main app.
    func returnToKeyboardFromApp() throws

    /// Handle any dictation result in the keyboard.
    func handleDictationResultInKeyboard() async throws

    /// Undo the last performed dictation operation, if any.
    func undoLastDictation()
}
