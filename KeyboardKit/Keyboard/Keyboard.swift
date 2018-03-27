//
//  Keyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2015-12-27.
//  Copyright © 2015 Daniel Saidi. All rights reserved.
//

import Foundation

open class Keyboard {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction]) {
        self.actions = actions
    }
    
    
    // MARK: - Properties
    
    open let actions: [KeyboardAction]
}


// MARK: - Public Extensions

public extension Keyboard {
    
    public static var empty: Keyboard {
        return Keyboard(actions: [])
    }
}
