//
//  CGFloat+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import UIKit

public extension CGFloat {
    
    /**
     The standard, `total` row height of a vertical keyboard
     row in a system keyboard, e.g. a row of input actions.
     
     Note that this is the total row height. It includes any
     additional top and bottom insets that should be applied
     within each row item view. These standard insets can be
     retrieved with `standardKeyboardRowItemInsets` and must
     be applied within each view to avoid dead tap areas.
     */
    static func standardKeyboardRowHeight(
        for device: UIDevice = .current,
        app: UIApplication = .shared) -> CGFloat {
        standardKeyboardRowHeight(
            for: device.userInterfaceIdiom,
            orientation: app.statusBarOrientation)
    }
}

extension CGFloat {
    
    /**
     This internal function is used by the unit test project.
     */
    static func standardKeyboardRowHeight(
        for idiom: UIUserInterfaceIdiom,
        orientation: UIInterfaceOrientation) -> CGFloat {
        orientation.isLandscape
            ? idiom == .pad ? 86 : 38
            : idiom == .pad ? 66 : 54
    }
}
