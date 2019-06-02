//
//  UIColor+TappableClear.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-06-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This color can be used by buttons that have a clear colored
 area that should be tappable (e.g. a transparent background).
 Using `.clear` as the background color for these areas will
 make gesture recognizers stop registering touches.
 
 */

import UIKit

public extension UIColor {

    static var clearTappable: UIColor {
        return UIColor(white: 1, alpha: 0.01)
    }
}
