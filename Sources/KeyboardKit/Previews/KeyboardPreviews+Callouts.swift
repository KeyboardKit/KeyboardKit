//
//  KeyboardPreviews+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension CalloutContext {

    static var preview = CalloutContext(
        actionContext: .preview,
        inputContext: .preview
    )
}

public extension CalloutContext.ActionContext {

    static var preview = CalloutContext.ActionContext(
        service: .preview,
        tapAction: { _ in }
    )
}

public extension CalloutContext.InputContext {
    
    static var preview = CalloutContext.InputContext(
        isEnabled: true
    )
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
    }
}
