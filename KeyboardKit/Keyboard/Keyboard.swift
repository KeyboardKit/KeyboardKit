//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 In KeyboardKit, a `Keyboard` is just an action carrier. The
 actions are then presented by the keyboard view controller.
 
 */

import Foundation

open class Keyboard {
    
    public init(id: String, actions: [KeyboardAction]) {
        self.id = id
        self.actions = actions
    }
    
    public init(actions: [KeyboardAction]) {
        self.id = nil
        self.actions = actions
    }
    
    
    public let id: String?
    public let actions: [KeyboardAction]
}

public extension Keyboard {
    
    static var empty: Keyboard {
        return Keyboard(actions: [])
    }
}
