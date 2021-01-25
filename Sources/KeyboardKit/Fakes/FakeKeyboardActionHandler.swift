//
//  FakeKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is a fake `KeyboardActionHandler`. It can be used when
 an action handler is needed, but it doesn't have to work.
 
 For instance, `SwiftUI` previews may require an instance to
 build, but the instance doesn't have to be real.
 */
public class FakeKeyboardActionHandler: KeyboardActionHandler {
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool { false }
    public func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {}
    public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
}
