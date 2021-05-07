//
//  UIInputViewController+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIInputViewController {
    
    /**
     Get the current screen orientation. If no window can be
     resolved `portrait` is returned.
     
     Note that you probably shouldn't use screen orientation,
     but rather use the controller traits instead.
     */
    var screenOrientation: UIInterfaceOrientation {
        view.window?.screen.orientation ?? .portrait
    }
}
