//
//  UIInputViewController+Screen.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIInputViewController {
    
    /**
     Get the current screen.
     */
    var windowScreen: UIScreen? {
        view.window?.screen
    }
}
#endif
