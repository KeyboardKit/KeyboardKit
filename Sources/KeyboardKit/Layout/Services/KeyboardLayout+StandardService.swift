//
//  KeyboardLayout+StandardService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-01.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardLayout {
    
    /// This class provides a standard way to create dynamic
    /// keyboard layouts.
    ///
    /// This class can register ``localizedServices``, which
    /// will then be used to resolve layouts for the locales
    /// they specify. If a ``KeyboardLocale`` is not handled
    /// by these locales the ``baseService`` is used.
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
        public var localizedServices: KeyboardLocale.Dictionary<KeyboardLayoutService>

        /// This is an optional resolver that is used by Pro to lazily resolve services.
        public static var localizedServiceResolver: ((KeyboardLocale) -> KeyboardLayoutService?)?

        
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
            let locale = context.keyboardLocale ?? .english
            if let service = localizedServices.value(for: locale) { return service }
            if let service = Self.localizedServiceResolver?(locale) {
                localizedServices.dictionary[locale.localeIdentifier] = service
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


        // MARK: - Deprecated

        @available(*, deprecated, renamed: "init(baseService:localizedServices:)")
        @_disfavoredOverload
        public convenience init(
            baseProvider: KeyboardLayoutService = KeyboardLayout.DeviceBasedService(),
            localizedProviders: [LocalizedLayoutService] = []
        ) {
            self.init(baseService: baseProvider, localizedServices: localizedProviders)
        }

        @available(*, deprecated, renamed: "LocalizedLayoutService")
        public typealias LocalizedProvider = LocalizedLayoutService

        @available(*, deprecated, renamed: "baseService")
        public private(set) var baseProvider: KeyboardLayoutService {
            get { baseService }
            set { baseService = newValue }
        }

        @available(*, deprecated, renamed: "localizedServices")
        public var localizedProviders: KeyboardLocale.Dictionary<KeyboardLayoutService> {
            get { localizedServices }
            set { localizedServices = newValue }
        }

        @available(*, deprecated, renamed: "localizedServiceResolver")
        public static var localizedProviderResolver: ((KeyboardLocale) -> KeyboardLayoutService?)? {
            get { localizedServiceResolver }
            set { localizedServiceResolver = newValue }
        }

        @available(*, deprecated, renamed: "keyboardLayoutService(for:)")
        open func keyboardLayoutProvider(
            for context: KeyboardContext
        ) -> KeyboardLayoutService {
            keyboardLayoutService(for: context)
        }

        @available(*, deprecated, renamed: "registerLocalizedService")
        open func registerLocalizedProvider(
            _ service: LocalizedLayoutService
        ) {
            localizedServices.set(service, for: service.localeKey)
        }
    }
}
