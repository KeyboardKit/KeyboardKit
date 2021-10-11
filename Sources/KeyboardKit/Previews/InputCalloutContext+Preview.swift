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
     This preview context can be used in SwiftUI previews.
     */
    static var preview: InputCalloutContext {
        InputCalloutContext(isEnabled: true)
    }
}
