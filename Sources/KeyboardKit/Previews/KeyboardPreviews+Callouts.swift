//
//  KeyboardPreviews+Callouts.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardCalloutContext {

    static var preview: KeyboardCalloutContext { .init() }
}

public extension KeyboardCalloutService where Self == Callouts.BaseCalloutService {

    static var preview: KeyboardCalloutService {
        Callouts.BaseCalloutService()
    }
}

public extension KeyboardPreviews {
    
    class CalloutService: Callouts.BaseCalloutService {

        public override func triggerFeedbackForSelectionChange() {}
    }
}
