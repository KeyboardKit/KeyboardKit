//
//  InputCalloutContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension InputCalloutContext {
    
    /**
     This property can be used to preview keyboard views. Do
     not use it in other situations.
     */
    static var preview: InputCalloutContext {
        InputCalloutContext()
    }
}
