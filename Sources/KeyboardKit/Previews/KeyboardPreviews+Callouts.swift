//
//  KeyboardPreviews+KeyboardCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardCalloutContext {

    static var preview: KeyboardCalloutContext {
        KeyboardCalloutContext()
    }
}

public extension KeyboardCalloutService where Self == KeyboardCallout.BaseCalloutService {

    static var preview: KeyboardCalloutService {
        KeyboardCallout.BaseCalloutService()
    }
}

@available(*, deprecated, message: "KeyboardCallout.BaseCalloutService is now used instead.")
public extension KeyboardPreviews {
    
    class CalloutService: KeyboardCalloutService {

        public func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
            switch action {
            case .character(let char):
                switch char {
                case "a": return "aàáâäǎæãåāăą".map { KeyboardAction.character(String($0)) }
                case "e": return "e".map { KeyboardAction.character(String($0)) }
                default: return []
                }
            default: break
            }
            return []
        }

        public func triggerFeedbackForSelectionChange() {}
    }
}
