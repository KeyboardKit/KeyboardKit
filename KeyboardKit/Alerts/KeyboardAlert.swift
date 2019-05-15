//
//  KeyboardAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be used to display alerts within keyboard
 extensions, since they don't support `UIAlertController`. A
 keyboard alert must be displayed within the extension, e.g.
 ontop of the keyboard.
 
 */

import Foundation

public protocol KeyboardAlert {
    
    func alert(message: String, in: UIView, withDuration: Double)
}
