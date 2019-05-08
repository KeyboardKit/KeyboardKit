//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 In KeyboardKit, a `Keyboard` is just an action carrier with
 an optional id. The actions can be displayed in any way.
 
 In the demo application, you can see how you can extend the
 keyboard class with more functionality, e.g. so that it can
 suggest a preferred stack view distribution mode, provide a
 set of real buttons given its actions etc.
 
 */

import Foundation

open class Keyboard {
    
    public init(id: String? = nil, actions: [KeyboardAction]) {
        self.id = id
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
