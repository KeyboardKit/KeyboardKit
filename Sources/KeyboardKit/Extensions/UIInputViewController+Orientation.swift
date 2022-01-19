//
//  UIInputViewController+Orientation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import UIKit

extension UIInputViewController {
    
    /**
     Get the current screen orientation. If no window can be
     resolved `portrait` is returned.
     */
    var screenOrientation: UIInterfaceOrientation {
        view.window?.screen.orientation ?? .portrait
    }
}
#endif
