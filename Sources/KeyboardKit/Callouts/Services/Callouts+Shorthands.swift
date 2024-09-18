//
//  Callouts+Shorthands.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-18.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutService where Self == Callouts.DisabledService {

    /// Create a disabled callout service.
    static var disabled: Self {
        Callouts.DisabledService()
    }
}

public extension CalloutService where Self == Callouts.StandardService {

    /// Create a standard callout service.
    ///
    /// - Parameters:
    ///   - keyboardContext: The keyboard context to use.
    ///   - baseService: The base service to use, by default a ``Callouts/BaseService``.
    ///   - localizedServices: A list of localized services, by default `empty`.
    ///   - feedbackService: The feedback service to use.
    static func standard(
        keyboardContext: KeyboardContext,
        baseService: CalloutService = Callouts.BaseService(),
        localizedServices: [Self.LocalizedCalloutService] = [],
        feedbackService: FeedbackService? = nil
    ) -> Self {
        Callouts.StandardService(
            keyboardContext: keyboardContext,
            baseService: baseService,
            localizedServices: localizedServices,
            feedbackService: feedbackService
        )
    }
}
