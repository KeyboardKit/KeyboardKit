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
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 `KeyboardKit` will automatically create a standard instance
 and bind it to the input view controller when the extension
 is started. It can be replaced with a custom one by setting
 the `keyboardInputCalloutContext` property.
 */
open class InputCalloutContext: ObservableObject {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    static let coordinateSpace = "com.keyboardkit.coordinate.InputCallout"
    
    /**
     The optional input of any currently active action.
     */
    public var input: String? { action?.input }
    
    /**
     Whether or not the context is enabled and has an input.
     */
    public var isActive: Bool { input != nil && isEnabled }
    
    /**
     Whether or not the context is enabled and will show any
     callout. This is true by default for phones, else false.
     */
    @Published public var isEnabled: Bool = UIDevice.current.userInterfaceIdiom == .phone
    
    /**
     The action that is currently active for the context.
     */
    @Published private(set) var action: KeyboardAction?
    
    /**
     The frame of the button that is active for the context.
     */
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
