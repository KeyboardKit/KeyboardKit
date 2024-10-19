//
//  Callouts+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-07-01.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutService where Self == Callouts.DisabledService {

    /// Create a ``Callouts/DisabledService`` instance.
    static var disabled: Self {
        Callouts.DisabledService()
    }
}

extension Callouts {

    /// Create a disabled callout service.
    ///
    /// This service can also be resolved with the shorthand
    /// ``CalloutService/disabled``.
    ///
    /// See <doc:Callouts-Article> for more information.
    open class DisabledService: CalloutService {

        /// Create a disabled callout service.
        public init() {}

        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            []
        }

        open func triggerFeedbackForSelectionChange() {}
    }
}
