//
//  Keyboard+KeyboardServices.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /**
     This type is used to retain keyboard service instances.
     
     This lets us decouple an input controller from any view
     that requires many service properties from it.
     
     Instead of passing the entire controller instance, pass
     in ``KeyboardInputViewController/keyboardServices``.
     */
    class KeyboardServices {
        
        
    }
}
