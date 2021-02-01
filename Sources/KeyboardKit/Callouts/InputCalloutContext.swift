//
//  InputCalloutContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to control input callout views, to
 present the currently typed character.
 
 You can use `.shared` to get/set a shared context.
 
 You can inherit this class and override any `open` function
 to modify the callout behavior.
 */
open class InputCalloutContext: ObservableObject {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    static let coordinateSpace = "com.keyboardkit.coordinate.InputCallout"
    
    public var input: String? { action?.input }
    open var isActive: Bool { input != nil && isEnabled }
    open var isEnabled: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    
    private var asyncTag = 0
    
    @Published private(set) var action: KeyboardAction?
    @Published private(set) var buttonFrame: CGRect = .zero
    
    
    // MARK: - Functions
    
    /**
     The visible button frame for the button view's geometry
     proxy. You can apply an inset by subclassing this class
     or adjusting the style.
     */
    open func buttonFrame(for geo: GeometryProxy) -> CGRect {
        geo.frame(in: .named(Self.coordinateSpace))
    }
    
    /**
     Reset the context, which will reset all state and cause
     any callouts to dismiss.
     */
    open func reset() {
        action = nil
        buttonFrame = .zero
    }
    
    /**
     Update the current input for a certain keyboard action.
     */
    open func updateInput(for action: KeyboardAction?, geo: GeometryProxy) {
        self.action = action
        self.buttonFrame = self.buttonFrame(for: geo)
    }
}

private extension KeyboardAction {
    
    var input: String? {
        switch self {
        case .character(let char): return char
        default: return nil
        }
    }
}
