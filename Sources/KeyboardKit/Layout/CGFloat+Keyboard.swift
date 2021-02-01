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
     The standard total height of a row in a system keyboard.
     
     Note that this is the TOTAL row height. It includes any
     additional vertical insets that may be applied to every
     row. Such insets must be applied to each button view to
     avoid dead tap areas.
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
