//
//  KeyboardAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol should be implemented by any classes that can
 display alerts in a keyboard extension.
 
 */

import Foundation

public protocol KeyboardAlert {
    
    func alert(message: String, in: UIView, withDuration: Double)
}
