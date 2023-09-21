//
//  CalloutContext+InputContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

public extension CalloutContext {
    
    /**
     This type can be used as input callout state.
     */
    class InputContext: ObservableObject {
        
        /**
         Create a new input callout context instance.
         
         - Parameters:
         - isEnabled: Whether or not callouts are enabled.
         */
        public init(isEnabled: Bool) {
            self.isEnabled = isEnabled
        }
        
        
        /// The coordinate space to use for callout.
        public let coordinateSpace = "com.keyboardkit.coordinate.InputCallout"
        
        
        /// The last time an action became active.
        public var lastActionDate = Date()
        
        /// The minimum callout duration.
        public var minimumVisibleDuration: TimeInterval = 0.05
        
        
        /// Whether or not input callouts are enabled.
        @Published
        public var isEnabled: Bool
        
        /// The currently active action, if any.
        @Published
        public private(set) var action: KeyboardAction?
        
        /// The frame of the currently active button.
        @Published
        public private(set) var buttonFrame: CGRect = .zero
    }
}


// MARK: - Public Functionality

public extension CalloutContext.InputContext {
    
    /// Whether or not the context currently has an input.
    var hasInput: Bool {
        input != nil
    }
    
    /// Get an optional input of the currently active action.
    var input: String? {
        action?.inputCalloutText
    }

    /// Whether or not the context has input and is enabled.
    var isActive: Bool {
        hasInput && isEnabled
    }
    
    /// Reset the context. This will dismiss the callout.
    func reset() {
        action = nil
        buttonFrame = .zero
    }
    
    /// Reset the context with a slight delay.
    func resetWithDelay() {
        let delay = minimumVisibleDuration
        let date = Date()
        lastActionDate = date
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.lastActionDate > date { return }
            self.reset()
        }
    }
    
    /// Update the current input for a certain action.
    func updateInput(for action: KeyboardAction?, in geo: GeometryProxy) {
        self.lastActionDate = Date()
        self.action = action
        self.buttonFrame = geo.frame(in: .named(coordinateSpace))
    }
}

// MARK: - Context Builders

public extension CalloutContext.InputContext {
    
    /// This context can be used to disable input callouts.
    static var disabled: CalloutContext.InputContext {
        .init(isEnabled: false)
    }
}
