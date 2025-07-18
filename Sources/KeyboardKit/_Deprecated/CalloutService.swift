//
//  CalloutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// > Warning: The callout service concept is deprecated and
/// will be removed in KeyboardKit 10.
///
/// This protocol can be implemented by any type that can be
/// used to perform keyboard-related callout actions.
public protocol CalloutService: AnyObject {

    /// Get callout actions for the provided keyboard action.
    func calloutActions(
        for action: KeyboardAction
    ) -> [KeyboardAction]

    /// Trigger feedback for callout selection change.
    func triggerFeedbackForSelectionChange()
}

public extension Callouts {

    /// This error can be thrown by ``CalloutService/tryRegisterLocalizedService(_:)``.
    enum TryRegisterLocalizedLayoutServiceError: Error {

        /// The service doesn't support localized layout service registrations.
        case serviceDoesNotSupportLocalizedServiceRegistration

        /// The provided service doesn't implement the ``LocalizedService`` protocol.
        case providedServiceDoesNotImplementLocalizedServiceProtocol
    }
}

public extension CalloutService {

    /// Try to register a localized service, which will then
    /// be used for the locale it specifies.
    ///
    /// - Parameters:
    ///   - service: The service to register.
    func tryRegisterLocalizedService(
        _ service: CalloutService
    ) throws {
        typealias ErrorType = KeyboardLayout.TryRegisterLocalizedLayoutServiceError
        let selfError = ErrorType.serviceDoesNotSupportLocalizedServiceRegistration
        let serviceError = ErrorType.providedServiceDoesNotImplementLocalizedServiceProtocol
        guard let _self = self as? Callouts.StandardCalloutService else { throw selfError }
        guard let service = service as? CalloutService & LocalizedService else { throw serviceError }
        _self.registerLocalizedService(service)
    }
}
