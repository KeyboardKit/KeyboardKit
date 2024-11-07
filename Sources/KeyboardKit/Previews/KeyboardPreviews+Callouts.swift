//
//  KeyboardPreviews+KeyboardCallout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardCalloutContext {

    static var preview: KeyboardCalloutContext {
        KeyboardCalloutContext()
    }
}

public extension KeyboardCalloutService where Self == KeyboardPreviews.PreviewKeyboardCalloutService {

    static var preview: KeyboardCalloutService {
        KeyboardPreviews.PreviewKeyboardCalloutService()
    }
}

public extension KeyboardPreviews {
    
    class PreviewKeyboardCalloutService: KeyboardCalloutService {

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
