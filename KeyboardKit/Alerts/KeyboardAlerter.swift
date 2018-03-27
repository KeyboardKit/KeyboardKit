//
//  KeyboardAlerter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by classes that can be used to
 display alerts in keyboard extensions.
 
 */

import Foundation

public protocol KeyboardAlerter {
    
    func alert(message: String, in: UIView, withDuration: Double)
}
