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
     This property can be used to preview keyboard views. Do
     not use it in other situations.
     */
    static var preview: SecondaryInputCalloutContext {
        SecondaryInputCalloutContext(
            actionProvider: PreviewSecondaryCalloutActionProvider(),
            actionHandler: PreviewKeyboardActionHandler())
    }
}
