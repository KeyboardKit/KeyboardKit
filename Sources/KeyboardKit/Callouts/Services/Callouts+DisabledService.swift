//
//  Callouts+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-07-01.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension Callouts {

    /// This service can be used to disable callout actions.
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
