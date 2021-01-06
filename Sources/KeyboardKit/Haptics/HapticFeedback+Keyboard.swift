//
//  HapticFeedback+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension HapticFeedback {

    /**
     The standard haptic feedback for a button tap.
     */
    static var standardTapFeedback: HapticFeedback {
        .lightImpact
    }

    /**
     The standard haptic feedback for a button double tap.
     */
    static var standardDoubleTapFeedback: HapticFeedback {
        .mediumImpact
    }
    
    /**
     The standard haptic feedback for a button long press.
    */
    static var standardLongPressFeedback: HapticFeedback {
        .heavyImpact
    }
}
