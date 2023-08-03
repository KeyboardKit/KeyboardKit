//
//  KeyboardCalloutContext+InputContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

public extension KeyboardCalloutContext {
    
    /**
     This context can be used to handle callouts that show a
     big version of the currently typed character.
     */
    class InputContext: ObservableObject {
        
        
        // MARK: - Initialization
        
        /**
         Create a new context instance,
         
         - Parameters:
         - isEnabled: Whether or not the context is enabled.
         */
        public init(isEnabled: Bool) {
            self.isEnabled = isEnabled
        }
        
        
        // MARK: - Properties
        
        /**
         This coordinate space is used when presenting callouts.
         */
        public static let coordinateSpace = "com.keyboardkit.coordinate.InputCallout"
        
        /**
         This value can be used to set the minimum duration of a
         callout.
         */
        public var minimumVisibleDuration: TimeInterval = 0.05
        
        
        // MARK: - Published Properties
        
        /**
         Whether or not the context is enabled, which means that
         it will show callouts as the user types.
         */
        @Published
        public var isEnabled: Bool
        
        /**
         The action that is currently active for the context.
         */
        @Published
        public private(set) var action: KeyboardAction?
        
        /**
         The frame of the button that is active for the context.
         */
        @Published
        public private(set) var buttonFrame: CGRect = .zero
        
        
        // MARK: - Functions
        
        /**
         Reset the context. This will cause any current callouts
         to be dismissed.
         */
        public func reset() {
            action = nil
            buttonFrame = .zero
        }
        
        /**
         Reset the context with a delay, which is useful when an
         input callout should be displayed a little while.
         */
        public func resetWithDelay() {
            let delay = minimumVisibleDuration
            let date = Date()
            lastActionDate = date
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if self.lastActionDate > date { return }
                self.reset()
            }
        }
        
        public var lastActionDate = Date()
        
        /**
         Update the current input for a certain keyboard action.
         */
        public func updateInput(for action: KeyboardAction?, in geo: GeometryProxy) {
            self.lastActionDate = Date()
            self.action = action
            self.buttonFrame = geo.frame(in: .named(Self.coordinateSpace))
        }
    }
}

public extension KeyboardCalloutContext.InputContext {
    
    /// This context can be used to disable input callouts.
    static var disabled: KeyboardCalloutContext.InputContext {
        .init(isEnabled: false)
    }
}

public extension KeyboardCalloutContext.InputContext {

    /**
     Get the optional input of any currently active action.
     */
    var input: String? {
        action?.inputCalloutText
    }

    /**
     Whether or not this context is active, which means that
     it's enabled and has an input.
     */
    var isActive: Bool {
        input != nil && isEnabled
    }
}
