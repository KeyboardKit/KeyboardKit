//
//  Keyboard+Services.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /// This type specifies global keyboard services.
    ///
    /// This lets us decouple the input view controller from
    /// any views that require its states and services. This
    /// reduces the risk of memory leaks.
    ///
    /// You can adjust or replace any service at any time to
    /// adjust your global keyboard behavior. Just make sure
    /// to replace a service before other services that have
    /// a dependency to that service are resolved.
    class Services {

        /// Create service instances based on keyboard state.
        ///
        /// - Parameters:
        ///   - state: The state to base the services on.
        public init(state: State) {
            self.state = state
            setupCalloutContextForServices()
        }


        /// The state to base the services on.
        private let state: State


        /// The keyboard action handler to use.
        public lazy var actionHandler: KeyboardActionHandler = .standard(
            for: nil,
            keyboardContext: state.keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: state.autocompleteContext,
            autocompleteService: autocompleteService,
            feedbackContext: state.feedbackContext,
            feedbackService: feedbackService,
            spaceDragGestureHandler: spaceDragGestureHandler
        ) {
            didSet { setupCalloutContextForServices() }
        }


        /// The autocomplete service to use.
        public lazy var autocompleteService: AutocompleteService = .disabled {
            didSet {
                guard let handler = actionHandler as? KeyboardAction.StandardActionHandler else { return }
                handler.autocompleteService = autocompleteService
            }
        }

        /// The callout service to use.
        public lazy var calloutService: KeyboardCalloutService = .standard(
            keyboardContext: state.keyboardContext,
            feedbackService: feedbackService
        ) {
            didSet { setupCalloutContextForServices() }
        }

        /// The dictation service to use.
        public lazy var dictationService: DictationService = .disabled

        /// The feedback service to use.
        public lazy var feedbackService: KeyboardFeedbackService = .standard

        /// The keyboard behavior to use.
        public lazy var keyboardBehavior: KeyboardBehavior = .standard(
            keyboardContext: state.keyboardContext,
            repeatGestureTimer: repeatGestureTimer
        ) {
            didSet {
                guard let handler = actionHandler as? KeyboardAction.StandardActionHandler else { return }
                handler.behavior = keyboardBehavior
            }
        }

        /// The keyboard layout service to use.
        public lazy var layoutService: KeyboardLayoutService = .standard() {
            didSet { state.keyboardContext.triggerKeyboardViewRefresh() }
        }

        /// The shared repeat gesture timer.
        public lazy var repeatGestureTimer = GestureButtonTimer()

        /// The space drag gesture handler to use.
        public lazy var spaceDragGestureHandler = Gestures.SpaceDragGestureHandler(
            sensitivity: .medium,
            action: { _ in }
        )

        /// The keyboard style service to use.
        public lazy var styleService: KeyboardStyleService = .standard(
            keyboardContext: state.keyboardContext
        )
    }
}

public extension Keyboard.Services {

    /// Try to register a localized service, which will then
    /// be used for the locale it specifies.
    ///
    /// - Parameters:
    ///   - service: The service to register.
    func tryRegisterLocalizedCalloutService(
        _ service: KeyboardCalloutService
    ) throws {
        try calloutService.tryRegisterLocalizedService(service)
    }

    /// Try to register a localized service, which will then
    /// be used for the locale it specifies.
    ///
    /// - Parameters:
    ///   - service: The service to register.
    func tryRegisterLocalizedLayoutService(
        _ service: KeyboardLayoutService
    ) throws {
        try layoutService.tryRegisterLocalizedService(service)
    }
}


#if os(iOS) || os(tvOS) || os(visionOS)
public extension Keyboard.Services {

    // Setup the service instance for the provided controller.
    func setup(for controller: KeyboardInputViewController) {
        setupActionHandler(for: controller)
        setupSpaceGesture(for: controller)
    }

    // Setup the action handler for the provided controller.
    func setupActionHandler(for controller: KeyboardInputViewController) {
        guard let handler = actionHandler as? KeyboardAction.StandardActionHandler else { return }
        weak var weakController = controller
        handler.keyboardController = weakController
    }

    // Setup space gestures for the provided controller.
    func setupSpaceGesture(for controller: KeyboardInputViewController) {
        weak var weakController = controller
        spaceDragGestureHandler.action = { [weak self] offset in
            let context = self?.state.keyboardContext
            let isLtr = context?.locale.isLeftToRight ?? true
            let rawOffset = context?.spaceDragOffset(for: offset) ?? offset
            let adjustedOffset = isLtr ? rawOffset : -rawOffset
            weakController?.adjustTextPosition(by: adjustedOffset)
        }
    }
}
#endif

private extension Keyboard.Services {

    func setupCalloutContextForServices() {
        state.calloutContext.calloutService = calloutService
        state.calloutContext.actionHandler = { [weak self] action in
            self?.actionHandler.handle(.release, on: action)
        }
    }
}
