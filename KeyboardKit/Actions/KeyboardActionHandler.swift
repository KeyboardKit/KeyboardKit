//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol can be used to handle user triggered keyboard
 actions. The `StandardKeyboardActionHandler` action handler
 is used by default by `KeyboardInputViewController`, but it
 can be replaced by a subclass that fills out the gaps or by
 a completely different action handler.
 
 */

import Foundation

public protocol KeyboardActionHandler: AnyObject {

    func handleTap(on action: KeyboardAction, view: UIView)
    func handleRepeat(on action: KeyboardAction, view: UIView)
    func handleLongPress(on action: KeyboardAction, view: UIView)
}
