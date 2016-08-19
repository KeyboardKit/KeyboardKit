//
//  UIView_Fade.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-14.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func fadeInWithDuration(duration: NSTimeInterval) {
        alpha = 0
        let animations = { self.alpha = 1 }
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations: animations) {
            completed in
        }
    }
    
    public func fadeOutWithDuration(duration: NSTimeInterval) {
        let animations = { self.alpha = 0 }
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations: animations) {
            completed in
        }
    }
}
