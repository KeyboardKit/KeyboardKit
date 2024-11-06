//
//  UIInputViewController+KeyboardKit.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-11-07.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Foundation
import UIKit

public extension UIInputViewController {

    /// Whether this controller is KeyboardKit enabled.
    var isKeyboardKitEnabledController: Bool {
        self is KeyboardInputViewController
    }
}
#endif
