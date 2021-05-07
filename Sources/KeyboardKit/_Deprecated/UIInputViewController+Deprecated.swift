//
//  UIInputViewController+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIInputViewController {
    
    @available(*, deprecated, message: "Use screenOrientation instead")
    var deviceOrientation: UIInterfaceOrientation { screenOrientation }
}
