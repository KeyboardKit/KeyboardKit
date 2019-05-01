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
 
 */

import Foundation

public struct Keyboard {
    
    public init(id: String? = nil, actions: [KeyboardAction]) {
        self.id = id
        self.actions = actions
    }
    
    public let id: String?
    public let actions: [KeyboardAction]
}
