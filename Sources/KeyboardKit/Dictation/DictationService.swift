//
//  DictationService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-21.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any classes that can
/// perform dictation by accessing the microphone.
///
/// This service does not work in keyboard extensions, since
/// extensions can't access the device microphone. Keyboards
/// must instead use a ``KeyboardDictationService``.
///
/// KeyboardKit doesn't have a standard dictation service as
/// it has for other services. Instead, a disabled dictation
/// service will be used until you register a custom service,
/// or register a valid KeyboardKit Pro license key.
///
/// See <doc:Dictation-Article> for more information.
///
/// > Note: The two dictation service types will probably be
/// merged in KeyboardKit 9.0.
public protocol DictationService: AnyObject {
    
    /// The current dictation authorization status.
    var authorizationStatus: Dictation.AuthorizationStatus { get }
    
    /// A list of supported locales.
    var supportedLocales: [Locale] { get }


    /// Request dictation authorization.
    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus

    /// Reset any previously set dictation result.
    func resetDictationResult() async throws

    /// Start dictating with the provided configuration.
    func startDictation(with config: Dictation.Configuration) async throws

    /// Stop dictating.
    func stopDictation() async throws
}
