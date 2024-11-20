//
//  KeyboardCalloutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to perform keyboard-related callout actions.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the callout behavior.
///
/// KeyboardKit Pro can be used to unlock localized services
/// for all ``Foundation/Locale/keyboardKitSupported``.
///
/// See <doc:Callouts-Article> for more information.
public protocol KeyboardCalloutService: AnyObject {

    /// Get callout actions for the provided keyboard action.
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]

    /// Trigger feedback for callout selection change.
    func triggerFeedbackForSelectionChange()
}

public extension KeyboardCallout {

    /// This error can be thrown by ``KeyboardCalloutService/tryRegisterLocalizedService(_:)``.
    enum TryRegisterLocalizedLayoutServiceError: Error {

        /// The service doesn't support localized layout service registrations.
        case serviceDoesNotSupportLocalizedServiceRegistration

        /// The provided service doesn't implement the ``LocalizedService`` protocol.
        case providedServiceDoesNotImplementLocalizedServiceProtocol
    }
}

public extension KeyboardCalloutService {

    /// Try to register a localized service, which will then
    /// be used for the locale it specifies.
    ///
    /// - Parameters:
    ///   - service: The service to register.
    func tryRegisterLocalizedService(
        _ service: KeyboardCalloutService
    ) throws {
        typealias ErrorType = KeyboardLayout.TryRegisterLocalizedLayoutServiceError
        let selfError = ErrorType.serviceDoesNotSupportLocalizedServiceRegistration
        let serviceError = ErrorType.providedServiceDoesNotImplementLocalizedServiceProtocol
        guard let _self = self as? KeyboardCallout.StandardCalloutService else { throw selfError }
        guard let service = service as? KeyboardCalloutService & LocalizedService else { throw serviceError }
        _self.registerLocalizedService(service)
    }
}
