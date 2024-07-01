//
//  Callouts+DisabledActionProvider.swift
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
    open class DisabledActionProvider: CalloutActionProvider {

        /// Create a disabled callout action provider.
        public init() {}

        /// Get callout actions for the provided action.
        public func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            []
        }
    }
}
