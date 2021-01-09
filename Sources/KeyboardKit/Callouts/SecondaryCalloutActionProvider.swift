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
 
 `IMPORTANT` This is an experimental new feature, that could
 be redesigned in any minor release until 4.0. 
 */
public protocol SecondaryCalloutActionProvider {
    
    func secondaryCalloutActions(for action: KeyboardAction, in context: KeyboardContext) -> [KeyboardAction]
}
