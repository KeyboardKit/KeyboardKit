//
//  ActionCalloutContext+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

public extension ActionCalloutContext {
    
    /**
     This preview context can be used in SwiftUI previews.
     */
    static var preview = ActionCalloutContext(
        actionHandler: .preview,
        actionProvider: .preview)
}
