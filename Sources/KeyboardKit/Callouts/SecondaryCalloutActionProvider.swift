//
//  SecondaryCalloutActionProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can return
 a set of secondary input characters for any keyboard action.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. It can be replaced with a custom one by setting
 the `keyboardSecondaryCalloutActionProvider` property.
 */
public protocol SecondaryCalloutActionProvider {
    
    func secondaryCalloutActions(for action: KeyboardAction) -> [KeyboardAction]
}
