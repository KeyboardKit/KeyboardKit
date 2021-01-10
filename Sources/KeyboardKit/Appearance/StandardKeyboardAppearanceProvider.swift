//
//  StandardKeyboardAppearanceProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This stnadard keybpard appearance provider just returns the
 standard values that are provided by various extensions.
 
 You can inherit this class and override any implementations
 to customize the standard appearance, or create a new class
 (decorator) that takes in another implementation then bases
 its logic on that implementation.
 */
open class StandardKeyboardAppearanceProvider: KeyboardAppearanceProvider {
    
    public init() {}
    
    open func text(for action: KeyboardAction, context: KeyboardContext) -> String? {
        action.standardButtonText
    }
}
