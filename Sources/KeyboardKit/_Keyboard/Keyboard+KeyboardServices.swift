//
//  Keyboard+KeyboardServices.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /**
     This type is used to specify keyboard service instances.
     
     The type lets us decouple an input view controller from
     any views that require services from it. You can config
     or replace any service instance at any time.
     
     Instead of passing the entire controller instance, just
     use ``KeyboardInputViewController/services``. This will
     reduce the risk of memory leaks.
     */
    class KeyboardServices {
        
        /// Create a service instance based on state.
        ///
        /// - Parameters:
        ///   - state: The state to base the services on.
        public init(state: KeyboardState) {
            self.state = state
            setupCalloutContextForServices()
        }
        
        
        /// The state to base the services on.
        private let state: KeyboardState
        
        
        /// The keyboard action handler to use.
        public lazy var actionHandler: KeyboardActionHandler = StandardKeyboardActionHandler(
            controller: nil,
            keyboardContext: state.keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: state.autocompleteContext,
            feedbackConfiguration: state.feedbackConfiguration,
            spaceDragGestureHandler: spaceDragGestureHandler
        ) {
            didSet { setupCalloutContextForServices() }
        }
        
        /// The autocomplete provider to use.
        public lazy var autocompleteProvider: AutocompleteProvider = .disabled
        
        /// The callout action provider to use.
        public lazy var calloutActionProvider: CalloutActionProvider = StandardCalloutActionProvider(
            keyboardContext: state.keyboardContext
        ) {
            didSet { setupCalloutContextForServices() }
        }
        
        /// The dictation service to use.
        public lazy var dictationService: KeyboardDictationService = .disabled(
            context: state.dictationContext
        )
        
        /// The keyboard behavior to use.
        public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
            keyboardContext: state.keyboardContext)
        
        /// The keyboard layout provider to use.
        public lazy var layoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()
        
        /// The space drag gesture handler to use.
        public lazy var spaceDragGestureHandler = Gestures.SpaceDragGestureHandler(
            sensitivity: .medium,
            action: { _ in }
        )
        
        /// The keyboard style provider to use.
        public lazy var styleProvider: KeyboardStyleProvider = StandardKeyboardStyleProvider(
            keyboardContext: state.keyboardContext)
    }
}

#if os(iOS) || os(tvOS)
public extension Keyboard.KeyboardServices {
    
    // Setup the service instance for the provided controller.
    func setup(for controller: KeyboardInputViewController) {
        setupActionHandler(for: controller)
        setupSpaceGesture(for: controller)
    }
    
    // Setup the action handler for the provided controller.
    func setupActionHandler(for controller: KeyboardInputViewController) {
        weak var weakController = controller
        (actionHandler as? StandardKeyboardActionHandler)?.keyboardController = weakController
    }
    
    // Setup space gestures for the provided controller.
    func setupSpaceGesture(for controller: KeyboardInputViewController) {
        weak var weakController = controller
        spaceDragGestureHandler.action = { [weak self] in
            let offset = self?.state.keyboardContext.spaceDragOffset(for: $0)
            weakController?.adjustTextPosition(by: offset ?? $0)
        }
    }
}
#endif

private extension Keyboard.KeyboardServices {
    
    func setupCalloutContextForServices() {
        let context = state.calloutContext.actionContext
        context.actionProvider = calloutActionProvider
        context.tapAction = { [weak self] action in
            self?.actionHandler.handle(.release, on: action)
        }
    }
}
