//
//  KeyboardLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any classes that can
/// generate keyboard layouts in various ways.
///
/// KeyboardKit will automatically setup a standard protocol
/// implementation in ``KeyboardInputViewController/services``
/// when the keyboard is launched. You can change or replace
/// it at any time to customize the keyboard layout.
///
/// KeyboardKit Pro can be used to unlock localized services
/// for all ``Foundation/Locale/keyboardKitSupported``.
///
/// See <doc:Layout-Article> for more information.
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
    /// if the current service can't be cast to a ``KeyboardLayout/StandardService``
    /// or the provided `service` doesn't implement ``LocalizedService``.
    func tryRegisterLocalizedService(
        _ service: KeyboardLayoutService
    ) throws {
        typealias ErrorType = KeyboardLayout.TryRegisterLocalizedLayoutServiceError
        let selfError = ErrorType.serviceDoesNotSupportLocalizedServiceRegistration
        let serviceError = ErrorType.providedServiceDoesNotImplementLocalizedServiceProtocol
        guard let _self = self as? KeyboardLayout.StandardService else { throw selfError }
        guard let service = service as? KeyboardLayoutService & LocalizedService else { throw serviceError }
        _self.registerLocalizedService(service)
    }
}
