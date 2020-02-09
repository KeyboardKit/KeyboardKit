//
//  UIView.AutoresizingMask_Extras.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView.AutoresizingMask {
    
    /**
     This autoresizing mask can be used to center any view
     within its parent.
     */
    static var centerInParent: UIView.AutoresizingMask {
        [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
    }
}
