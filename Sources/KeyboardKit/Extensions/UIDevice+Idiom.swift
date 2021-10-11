//
//  UIDevice+Idiom.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /**
     Whether or not the device is an iPad.
     */
    var isPad: Bool { userInterfaceIdiom == .pad }
    
    /**
     Whether or not the device is an iPhone.
     */
    var isPhone: Bool { userInterfaceIdiom == .phone }
}
