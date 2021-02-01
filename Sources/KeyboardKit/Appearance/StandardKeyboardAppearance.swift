//
//  StandardKeyboardAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This standard appearance returns a style that mimics native
 system keyboards.
 
 You can inherit this class then override any parts you like
 to customize the standard appearance.
 */
open class StandardKeyboardAppearance: KeyboardAppearance {
    
    public init() {}
    
    open func font(for action: KeyboardAction) -> UIFont {
        action.standardButtonFont
    }
    
    open func fontWeight(for action: KeyboardAction) -> UIFont.Weight? {
        let hasImage = image(for: action) != nil
        return hasImage ? .light : nil
    }
    
    public func image(for action: KeyboardAction) -> Image? {
        action.standardButtonImage
    }
    
    open func text(for action: KeyboardAction) -> String? {
        action.standardButtonText
    }
}
