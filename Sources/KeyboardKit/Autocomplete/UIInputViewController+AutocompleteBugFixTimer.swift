//
//  UIInputViewController+AutocompleteBugFixTimer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-18.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIInputViewController {
    
    /**
     
     Create an autocomplete bug fix timer.
     
     This is a convenience function, that makes the creation
     more streamlined in view controllers that use these bug
     fix timers.
     
    */
    func createAutocompleteBugFixTimer(
        withTickInterval tickInterval: TimeInterval = 1,
        reversalInterval: TimeInterval = 0.0001) -> AutocompleteBugFixTimer {
        return AutocompleteBugFixTimer(
            viewController: self,
            tickInterval: tickInterval,
            reversalInterval: reversalInterval)
    }
}
