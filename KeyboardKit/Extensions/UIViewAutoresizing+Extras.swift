//
//  UIView.AutoresizingMask_Extras.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

public extension UIView.AutoresizingMask {
    
    /**
     
     This mask can be used to adjust a view's autoresizing
     behavior to center it within its parent.
     
     */
    
    static var centerInParent: UIView.AutoresizingMask {
        return [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
    }
}
