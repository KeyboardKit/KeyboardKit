//
//  UIInputViewController+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIInputViewController {
    
    /**
     Get the current device orientation. If no window can be
     resolved `portrait` is returned.
     
     Note that you probably shouldn't use device orientation,
     but rather use the input view controller's traits.
     */
    var deviceOrientation: UIInterfaceOrientation {
        view.window?.screen.orientation ?? .portrait
    }
}
