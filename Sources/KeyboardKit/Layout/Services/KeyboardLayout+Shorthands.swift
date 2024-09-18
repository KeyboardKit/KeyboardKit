//
//  KeyboardLayout+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayoutService where Self == KeyboardLayout.DisabledService {

    /// Create a disabled keyboard layout service.
    static var disabled: Self {
        KeyboardLayout.DisabledService()
    }
}

public extension KeyboardLayoutService where Self == KeyboardLayout.StandardService {

    /// Create a standard keyboard layout service.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - baseService: The base service to use, by default a ``Callouts/BaseService``.
    ///   - localizedServices: A list of localized services, by default `empty`.
    ///   - feedbackService: The feedback service to use.
    static func standard(
        baseService: KeyboardLayoutService = KeyboardLayout.DeviceBasedService(),
        localizedServices: [Self.LocalizedLayoutService] = []
    ) -> Self {
        KeyboardLayout.StandardService(
            baseService: baseService,
            localizedServices: localizedServices
        )
    }
}
