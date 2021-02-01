//
//  SecondaryInputCalloutContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension SecondaryInputCalloutContext {
    
    /**
     This preview can be used when previewing keyboard views
     that depend on an `ObservableKeyboardContext`.
     */
    static var preview: SecondaryInputCalloutContext {
        SecondaryInputCalloutContext(
            context: FakeKeyboardContext(),
            actionProvider: StandardSecondaryCalloutActionProvider(),
            actionHandler: FakeKeyboardActionHandler())
    }
}
