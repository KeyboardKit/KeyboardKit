//
//  KeyboardActionHandler+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import CoreGraphics

public extension KeyboardActionHandler where Self == PreviewKeyboardActionHandler {
    
    /**
     This preview handler can be used in SwiftUI previews.
     */
    static var preview: KeyboardActionHandler { PreviewKeyboardActionHandler() }
}

/**
 This action handler can be used in SwiftUI previews.
 */
public class PreviewKeyboardActionHandler: KeyboardActionHandler {
    
    public init() {}
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool { false }
    public func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {}
    public func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {}
}
