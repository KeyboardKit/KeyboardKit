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
 triggered keyboard actions.
 
 A `StandardKeyboardActionHandler` is used by default by the
 `KeyboardInputViewController` class, but you can replace it
 with you own subclass (see demo), or a completely different
 implementation.
 */
public protocol KeyboardActionHandler: AnyObject {

    func handleTap(on action: KeyboardAction, view: UIView)
    func handleRepeat(on action: KeyboardAction, view: UIView)
    func handleLongPress(on action: KeyboardAction, view: UIView)
}
