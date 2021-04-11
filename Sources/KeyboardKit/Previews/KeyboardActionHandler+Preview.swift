//
//  KeyboardActionHandler+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import CoreGraphics

/**
 This class can be used to preview keyboard views. Don't use
 it in other situations.
 */
public class PreviewKeyboardActionHandler: KeyboardActionHandler {
    
    public init() {}
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool { false }
    public func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {}
    public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
}
