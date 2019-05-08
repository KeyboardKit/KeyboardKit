//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is used to handle keyboard action events that
 are triggered by the user.
 
 */

import Foundation

public protocol KeyboardActionHandler: AnyObject {

    func handleLongPress(on view: UIView, action: KeyboardAction)
    func handleTap(on view: UIView, action: KeyboardAction)
}
