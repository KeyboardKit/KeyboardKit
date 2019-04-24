//
//  KeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard action handlers are used to handle keyboard action
 events that are triggered by the user.
 
 */

import Foundation

public protocol KeyboardActionHandler {

    func handleLongPress(on action: KeyboardAction)
    func handleTap(on action: KeyboardAction)
}
