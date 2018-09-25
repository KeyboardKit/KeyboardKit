//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

/*
 
 In this version of KeyboardKit, `Keyboard` is just a simple
 action carrier, while all logic is handled by the extension.
 It would however probably be better to build in some of the
 logic into the keyboard, like how some actions are handled.
 
 */

import Foundation

open class Keyboard {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction]) {
        self.actions = actions
    }
    
    
    // MARK: - Properties
    
    public let actions: [KeyboardAction]
}


// MARK: - Public Extensions

public extension Keyboard {
    
    public static var empty: Keyboard {
        return Keyboard(actions: [])
    }
}
