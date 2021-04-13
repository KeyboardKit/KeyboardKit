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
     The standard corner radius of a system keyboard button.
     */
    static var standardKeyboardButtonCornerRadius: CGFloat {
        standardKeyboardButtonCornerRadius()
    }
    
    /**
     The standard, total height, including insets, for a row
     in a system keyboard.
     */
    static var standardKeyboardRowHeight: CGFloat {
        standardKeyboardRowHeight()
    }
    
    /**
     The standard corner radius of a system keyboard button.
     */
    static func standardKeyboardButtonCornerRadius(
        for device: UIDevice = .current) -> CGFloat {
        4.0
    }
    
    /**
     The standard, total height, including insets, for a row
     in a system keyboard.
     */
    static func standardKeyboardRowHeight(
        for device: UIDevice = .current,
        app: UIApplication = .shared) -> CGFloat {
        standardKeyboardRowHeight(
            for: device.userInterfaceIdiom,
            orientation: app.preferredKeyboardInterfaceOrientation)
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
