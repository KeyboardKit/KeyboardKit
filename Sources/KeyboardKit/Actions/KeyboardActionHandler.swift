//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This protocol can be implemented by classes that can handle
 keyboard actions that are triggered in a keyboard extension.
 
 The standard `StandardKeyboardActionHandler` action handler
 is used by default by `KeyboardInputViewController`. It can
 be subclassed and extended with app-specific logic (see the
 demo) or replaced by a completely different implementation.
 */
public protocol KeyboardActionHandler: AnyObject {

    func handleTap(on action: KeyboardAction, view: UIView)
    func handleRepeat(on action: KeyboardAction, view: UIView)
    func handleLongPress(on action: KeyboardAction, view: UIView)
}
