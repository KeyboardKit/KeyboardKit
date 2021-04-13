//
//  UIApplication+Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    /**
     Get the interface orientation of the first window scene,
     if any. If no scene is found, `.unknown` is returned.
     */
    var preferredKeyboardInterfaceOrientation: UIInterfaceOrientation {
        let scene = windows.first?.windowScene
        return scene?.interfaceOrientation ?? .unknown
    }
}
