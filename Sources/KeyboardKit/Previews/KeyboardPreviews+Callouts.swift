//
//  KeyboardPreviews+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutContext {

    static var preview: CalloutContext {
        CalloutContext()
    }
}

public extension CalloutService where Self == KeyboardPreviews.PreviewCalloutService {

    static var preview: CalloutService {
        KeyboardPreviews.PreviewCalloutService()
    }
}

public extension KeyboardPreviews {
    
    class PreviewCalloutService: CalloutService {

        public func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
            switch action {
            case .character(let char):
                switch char {
                case "a": return "aàáâäæãåā".map { KeyboardAction.character(String($0)) }
                default: return []
                }
            default: break
            }
            return []
        }

        public func triggerFeedbackForSelectionChange() {}
    }
}
