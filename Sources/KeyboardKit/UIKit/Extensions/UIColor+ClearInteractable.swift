//
//  UIColor+ClearInteractable.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-06-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIColor {

    /**
     This color can be used instead of `.clear`, which makes
     a view stop registering touches and gestures.
     */
    static var clearInteractable: UIColor {
        UIColor(white: 1, alpha: 0.005)
    }
}
