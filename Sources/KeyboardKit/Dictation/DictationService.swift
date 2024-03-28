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
/// See <doc:Autocomplete-Article> for information on how to
/// perform dictation with KeyboardKit.
///
/// KeyboardKit does not have a standard provider, as it has
/// fo other services. Instead, a disabled provider instance
/// will be used until you register a real one or register a
/// valid KeyboardKit Pro license key.
///
/// To create a custom implementation, either implement this
/// protocol from scratch, or inherit any of the Pro classes
/// and override anything you want to change, then inject it
/// into ``KeyboardInputViewController/services`` to make it
/// the global default.
public protocol DictationService: AnyObject {
    
    /// The current dictation authorization status.
    var authorizationStatus: Dictation.AuthorizationStatus { get }
    
    /// A list of supported locales.
    var supportedLocales: [KeyboardLocale] { get }


    /// Request dictation authorization.
    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus

    /// Reset any previously set dictation result.
    func resetDictationResult() async throws

    /// Start dictating with the provided configuration.
    func startDictation(with config: Dictation.Configuration) async throws

    /// Stop dictating.
    func stopDictation() async throws
}
