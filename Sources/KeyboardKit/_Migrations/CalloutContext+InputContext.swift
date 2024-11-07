//
//  CalloutContext+InputContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use CalloutContext instead.")
public extension CalloutContext {
    
    class InputContext: ObservableObject {
        
        public init(isEnabled: Bool) {
            self.isEnabled = isEnabled
        }
        
        public let coordinateSpace = "com.keyboardkit.coordinate.InputCallout"

        public var lastActionDate = Date()
        
        public var minimumVisibleDuration: TimeInterval = 0.05
        
        @Published
        public var isEnabled: Bool
        
        @Published
        public private(set) var action: KeyboardAction?
        
        @Published
        public private(set) var buttonFrame: CGRect = .zero
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension CalloutContext.InputContext {
    
    var hasInput: Bool {
        input != nil
    }
    
    var input: String? {
        action?.inputCalloutText
    }

    var isActive: Bool {
        hasInput && isEnabled
    }
    
    func reset() {
        action = nil
        buttonFrame = .zero
    }
    
    func resetWithDelay() {
        let delay = minimumVisibleDuration
        let date = Date()
        lastActionDate = date
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.lastActionDate > date { return }
            self.reset()
        }
    }
    
    func updateInput(for action: KeyboardAction?, in geo: GeometryProxy) {
        self.lastActionDate = Date()
        self.action = action
        self.buttonFrame = geo.frame(in: .named(coordinateSpace))
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension CalloutContext.InputContext {
    
    static var disabled: CalloutContext.InputContext {
        .init(isEnabled: false)
    }

    static var preview: CalloutContext.InputContext {
        CalloutContext.InputContext(
            isEnabled: true
        )
    }
}
