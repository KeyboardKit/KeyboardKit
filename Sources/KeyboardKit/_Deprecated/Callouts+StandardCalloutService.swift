//
//  Callouts+StandardCalloutService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutService where Self == Callouts.StandardCalloutService {

    /// > Deprecated: The callout service concept will be removed in KeyboardKit 10.
    ///
    /// Create a ``Callouts/StandardCalloutService`` instance.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - baseService: The base service to use, by default a ``Callouts/BaseCalloutService``.
    ///   - localizedServices: A list of localized services, by default `empty`.
    ///   - feedbackService: The feedback service to use.
    static func standard(
        keyboardContext: KeyboardContext,
        baseService: CalloutService = Callouts.BaseCalloutService(),
        localizedServices: [Self.LocalizedCalloutService] = [],
        feedbackService: FeedbackService? = nil
    ) -> Self {
        Callouts.StandardCalloutService(
            keyboardContext: keyboardContext,
            baseService: baseService,
            localizedServices: localizedServices,
            feedbackService: feedbackService
        )
    }
}

extension Callouts {

    /// > Deprecated: The callout service concept will be removed in KeyboardKit 10.
    ///
    /// This service class provides a standard way to handle
    /// keyboard callouts.
    open class StandardCalloutService: CalloutService {

        /// Create a standard callout service.
        ///
        /// - Parameters:
        ///   - keyboardContext: The keyboard context to use.
        ///   - baseService: The base service to use, by default a ``Callouts/BaseCalloutService``.
        ///   - localizedServices: A list of localized services, by default `empty`.
        ///   - feedbackService: The feedback service to use.
        public init(
            keyboardContext: KeyboardContext,
            baseService: CalloutService = Callouts.BaseCalloutService(),
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
        public var localizedServices: Locale.Dictionary<CalloutService>

        /// This resolver is used to lazily resolve services.
        public static var localizedServiceResolver: ((Locale) -> CalloutService?)?

        
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
            if let service = localizedServices.value(for: locale) { return service }
            if let service = Self.localizedServiceResolver?(locale) {
                localizedServices.dictionary[locale.identifier] = service
                return service
            }
            return baseService
        }
    }
}
