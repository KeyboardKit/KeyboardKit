//
//  MessageAlert.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-08-22.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol MessageAlert {
    
    func alertMessage(message: String, inView: UIView, duration: Double)
}
