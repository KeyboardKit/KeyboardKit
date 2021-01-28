//
//  UIKeyboardAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by classes that can show a
 message alert in a keyboard extension. Keyboard alerts must
 be custom made, since keyboard extensions don't support the
 regular `UIAlertController` alert.
 */
public protocol UIKeyboardAlert {
    
    func alert(message: String, in view: UIView, withDuration: Double)
}
