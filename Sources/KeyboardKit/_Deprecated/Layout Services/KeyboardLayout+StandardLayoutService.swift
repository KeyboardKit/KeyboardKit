//
//  KeyboardLayout+StandardLayoutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayoutService where Self == KeyboardLayout.StandardLayoutService {

    /// Create a standard layout service.
    ///
    /// - Parameters:
    ///   - baseService: The base service to use, by default a device-based service.
    ///   - localizedServices: A list of localized services, by default `empty`.
    static func standard(
        baseService: KeyboardLayoutService = KeyboardLayout.DeviceBasedLayoutService(),
        localizedServices: [Self.LocalizedLayoutService] = []
    ) -> Self {
        KeyboardLayout.StandardLayoutService(
            baseService: baseService,
            localizedServices: localizedServices
        )
    }
}

extension KeyboardLayout {

    /// > Deprecated: These services will be removed in 10.0.
    ///
    /// This class provides a standard way to create dynamic
    /// keyboard layouts.
    open class StandardLayoutService: KeyboardLayoutService {

        /// Create a standard keyboard layout service.
        ///
        /// - Parameters:
        ///   - baseService: The base service, by default a ``KeyboardLayout/DeviceBasedLayoutService``.
        ///   - localizedServices: A list of localized layout services, by default `empty`.
        public init(
            baseService: KeyboardLayoutService = KeyboardLayout.DeviceBasedLayoutService(),
            localizedServices: [LocalizedLayoutService] = []
        ) {
            self.baseService = baseService
            let dict = Dictionary(uniqueKeysWithValues: localizedServices.map { ($0.localeKey, $0) })
            self.localizedServices = .init(dict)
        }

        
        /// This typealias represents a localized service.
        public typealias LocalizedLayoutService = KeyboardLayoutService & LocalizedService

        
        /// The base service to use.
        public private(set) var baseService: KeyboardLayoutService

        /// A dictionary with localized layout services.
        public var localizedServices: Locale.Dictionary<KeyboardLayoutService>

        /// This is an optional resolver that is used by Pro to lazily resolve services.
        public static var localizedServiceResolver: ((Locale) -> KeyboardLayoutService?)?

        
        /// The keyboard layout to use for a certain context.
        open func keyboardLayout(
            for context: KeyboardContext
        ) -> KeyboardLayout {
            keyboardLayoutService(for: context)
                .keyboardLayout(for: context)
        }
        
        /// The layout service to use for a given context.
        open func keyboardLayoutService(
            for context: KeyboardContext
        ) -> KeyboardLayoutService {
            let locale = context.locale
            if let service = localizedServices.value(for: locale) { return service }
            if let service = Self.localizedServiceResolver?(locale) {
                localizedServices.dictionary[locale.identifier] = service
                return service
            }
            return baseService
        }
        
        /// Register a localized service
        open func registerLocalizedService(
            _ service: LocalizedLayoutService
        ) {
            localizedServices.set(service, for: service.localeKey)
        }
    }
}
