//
//  Callouts+StandardService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Callouts {
    
    /// This service class provides a standard way to handle
    /// keyboard callouts.
    ///
    /// The class can register ``localizedProviders``, which
    /// will then be used to resolve actions for the locales
    /// they specify. If a ``KeyboardLocale`` is not handled
    /// by these locales the ``baseProvider`` is used.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Callouts-Article> for more information.
    open class StandardService: CalloutService {

        /// Create a standard callout service.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - baseService: The base service to use, by default a ``Callouts/BaseService``.
        ///   - localizedServices: A list of localized services, by default `empty`.
        ///   - feedbackService: The feedback service to use.
        public init(
            keyboardContext: KeyboardContext,
            baseService: CalloutService = Callouts.BaseService(),
            localizedServices: [LocalizedCalloutService] = [],
            feedbackService: FeedbackService? = nil
        ) {
            self.keyboardContext = keyboardContext
            self.baseService = baseService
            let dict = Dictionary(uniqueKeysWithValues: localizedServices.map { ($0.localeKey, $0) })
            self.localizedServices = .init(dict)
            self.feedbackService = feedbackService
        }


        /// This typealias represents a localized service.
        public typealias LocalizedCalloutService = CalloutService & LocalizedService

        
        /// The keyboard context to use.
        public let keyboardContext: KeyboardContext

        /// The feedback service to use.
        public var feedbackService: FeedbackService?


        /// The base service to use.
        public private(set) var baseService: CalloutService

        /// This dictionary contains localized services.
        public var localizedServices: KeyboardLocale.Dictionary<CalloutService>

        /// This resolver is used to lazily resolve services.
        public static var localizedServiceResolver: ((KeyboardLocale) -> CalloutService?)?

        
        // MARK: - CalloutService

        /// Get callout actions for the provided action.
        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            service(for: keyboardContext)
                .calloutActions(for: action)
        }

        /// Trigger feedback for callout selection change.
        open func triggerFeedbackForSelectionChange() {
            feedbackService?.triggerHapticFeedback(.selectionChanged)
        }


        // MARK: - Overridable Functions

        /// Register a new localized service.
        open func registerLocalizedService(
            _ service: LocalizedCalloutService
        ) {
            localizedServices.set(service, for: service.localeKey)
        }

        /// Get the service to use for the provided context.
        open func service(
            for context: KeyboardContext
        ) -> CalloutService {
            service(for: context.locale)
        }

        /// Get the service to use for the provided locale.
        open func service(
            for locale: Locale
        ) -> CalloutService {
            let locale = KeyboardLocale(for: locale) ?? .english
            if let service = localizedServices.value(for: locale) { return service }
            if let service = Self.localizedServiceResolver?(locale) {
                localizedServices.dictionary[locale.localeIdentifier] = service
                return service
            }
            return baseService
        }


        // MARK: - Deprecated

        @available(*, deprecated, message: "Use the baseService initializer instead.")
        @_disfavoredOverload
        public convenience init(
            keyboardContext: KeyboardContext,
            baseProvider: CalloutService
        ) {
            self.init(
                keyboardContext: keyboardContext,
                baseService: baseProvider,
                localizedServices: []
            )
        }

        @available(*, deprecated, message: "Use the baseService initializer instead.")
        @_disfavoredOverload
        public convenience init(
            keyboardContext: KeyboardContext,
            localizedProviders: [LocalizedProvider]
        ) {
            self.init(
                keyboardContext: keyboardContext,
                baseService: Callouts.BaseService(),
                localizedServices: localizedProviders
            )
        }


        @available(*, deprecated, renamed: "LocalizedCalloutService")
        public typealias LocalizedProvider = CalloutService & LocalizedService

        @available(*, deprecated, renamed: "baseService")
        public private(set) var baseProvider: CalloutService {
            get { baseService }
            set { baseService = newValue }
        }

        @available(*, deprecated, renamed: "localizedServices")
        public var localizedProviders: KeyboardLocale.Dictionary<CalloutService> {
            get { localizedServices }
            set { localizedServices = newValue }
        }

        @available(*, deprecated, renamed: "localizedServiceResolver")
        public static var localizedProviderResolver: ((KeyboardLocale) -> CalloutService?)? {
            get { localizedServiceResolver }
            set { localizedServiceResolver = newValue }
        }

        @available(*, deprecated, renamed: "service(for:)")
        open func calloutActionProvider(
            for context: KeyboardContext
        ) -> CalloutService {
            service(for: context)
        }
        
        @available(*, deprecated, renamed: "service(for:)")
        open func calloutActionProvider(
            for locale: Locale
        ) -> CalloutService {
            service(for: locale)
        }
        
        @available(*, deprecated, renamed: "registerLocalizedService")
        open func registerLocalizedProvider(
            _ service: LocalizedCalloutService
        ) {
            localizedServices.set(service, for: service.localeKey)
        }
    }
}
