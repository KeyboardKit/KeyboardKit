//
//  KeyboardLayout+StandardService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardLayoutService where Self == KeyboardLayout.StandardService {

    /// Create a ``KeyboardLayout/StandardService`` instance.
    ///
    /// - Parameters:
    ///   - baseService: The base service to use, by default a device-based service.
    ///   - localizedServices: A list of localized services, by default `empty`.
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

extension KeyboardLayout {
    
    /// This class provides a standard way to create dynamic
    /// keyboard layouts.
    ///
    /// This class can register ``localizedServices``, which
    /// will then be used instead of ``baseService`` for the
    /// locales it specifies.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// This service can also be resolved with the shorthand
    /// ``KeyboardLayoutService/standard(baseService:localizedServices:)``. 
    ///
    /// See <doc:Layout-Article> for more information.
    open class StandardService: KeyboardLayoutService {

        /// Create a standard keyboard layout service.
        ///
        /// - Parameters:
        ///   - baseService: The base service, by default a ``KeyboardLayout/DeviceBasedService``.
        ///   - localizedServices: A list of localized layout services, by default `empty`.
        public init(
            baseService: KeyboardLayoutService = KeyboardLayout.DeviceBasedService(),
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
