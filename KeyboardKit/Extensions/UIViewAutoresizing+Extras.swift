//
//  UIViewAutoresizing_Extras.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This extension provides handy autoresizing options for when
 you are to position a subview in a superview.
 
 */

extension UIViewAutoresizing {
    
    static var centerInParent: UIViewAutoresizing {
        return [
            .flexibleTopMargin, .flexibleBottomMargin,
            .flexibleLeftMargin, .flexibleRightMargin
        ]
    }
    
    static var fillInParent: UIViewAutoresizing {
        return [.flexibleWidth, .flexibleHeight]
    }
}
