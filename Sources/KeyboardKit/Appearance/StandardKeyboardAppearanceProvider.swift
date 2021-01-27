//
//  StandardKeyboardAppearanceProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This stnadard keybpard appearance provider just returns the
 standard values that are provided by various extensions.
 
 You can inherit this class and override any implementations
 to customize the standard appearance.
 */
open class StandardKeyboardAppearanceProvider: KeyboardAppearanceProvider {
    
    public init() {}
    
    open func font(for action: KeyboardAction) -> Font {
        action.standardButtonFont
    }
    
    open func fontWeight(for action: KeyboardAction, context: KeyboardContext) -> Font.Weight? {
        return nil
    }
    
    open func text(for action: KeyboardAction) -> String? {
        action.standardButtonText
    }
    
    open func image(for action: KeyboardAction, context: KeyboardContext) -> Image? {
        action.standardButtonImage(for: context)
    }
}
