//
//  KeyboardLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// > Deprecated: This protocol will be removed in 10.0. Use
/// the new `.keyboardLayout` view modifier instead.
///
/// This protocol can be implemented by any classes that can
/// generate keyboard layouts in various ways.
public protocol KeyboardLayoutService: AnyObject {

    /// Get a keyboard layout for the provided context.
    func keyboardLayout(
        for context: KeyboardContext
    ) -> KeyboardLayout
}

public extension KeyboardLayout {

    /// This error can be thrown by ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.
    enum TryRegisterLocalizedLayoutServiceError: Error {

        /// The service doesn't support localized layout service registrations.
        case serviceDoesNotSupportLocalizedServiceRegistration

        /// The provided service doesn't implement the ``LocalizedService`` protocol.
        case providedServiceDoesNotImplementLocalizedServiceProtocol
    }
}

public extension KeyboardLayoutService {

    /// Try to register a localized layout service.
    ///
    /// - Parameters:
    ///   - service: The service to register.
    ///
    /// - Throws: ``KeyboardLayout/TryRegisterLocalizedLayoutServiceError``
    /// if the current service can't be cast to a ``KeyboardLayout/StandardLayoutService``
    /// or the provided `service` doesn't implement ``LocalizedService``.
    func tryRegisterLocalizedService(
        _ service: KeyboardLayoutService
    ) throws {
        typealias ErrorType = KeyboardLayout.TryRegisterLocalizedLayoutServiceError
        let selfError = ErrorType.serviceDoesNotSupportLocalizedServiceRegistration
        let serviceError = ErrorType.providedServiceDoesNotImplementLocalizedServiceProtocol
        guard let _self = self as? KeyboardLayout.StandardLayoutService else { throw selfError }
        guard let service = service as? KeyboardLayoutService & LocalizedService else { throw serviceError }
        _self.registerLocalizedService(service)
    }
}
