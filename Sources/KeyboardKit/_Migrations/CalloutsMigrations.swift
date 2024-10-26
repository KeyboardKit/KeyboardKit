//
//  Callouts+DisabledService.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-07-01.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension CalloutService where Self == Callouts.DisabledService {

    static var disabled: Self {
        Callouts.DisabledService()
    }
}

extension Callouts {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    open class DisabledService: CalloutService {

        public init() {}

        open func calloutActions(
            for action: KeyboardAction
        ) -> [KeyboardAction] {
            []
        }

        open func triggerFeedbackForSelectionChange() {}
    }
}
