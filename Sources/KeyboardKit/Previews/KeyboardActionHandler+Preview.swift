//
//  KeyboardActionHandler+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This fake action handler can be used for previews etc.
 */
public class PreviewKeyboardActionHandler: KeyboardActionHandler {
    
    public init() {}
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool { false }
    public func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {}
    public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
}
