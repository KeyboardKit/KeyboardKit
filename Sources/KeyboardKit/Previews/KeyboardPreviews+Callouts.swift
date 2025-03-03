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

public extension KeyboardPreviews {
    
    class CalloutService: KeyboardCallout.BaseCalloutService {

        public override func triggerFeedbackForSelectionChange() {}
    }
}
