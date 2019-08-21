//
//  KeyboardAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-02-01.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be used to display alerts within keyboard
 extensions, since they don't support `UIAlertController`.
 */
public protocol KeyboardAlert {
    
    func alert(message: String, in: UIView, withDuration: Double)
}
