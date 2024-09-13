//
//  Keyboard+Services.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
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
        public lazy var actionHandler: KeyboardActionHandler = KeyboardAction.StandardHandler(
            controller: nil,
            keyboardContext: state.keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: state.autocompleteContext,
            feedbackContext: state.feedbackContext,
            feedbackService: feedbackService,
            spaceDragGestureHandler: spaceDragGestureHandler
        ) {
            didSet { setupCalloutContextForServices() }
        }

        /// The autocomplete service to use.
        public lazy var autocompleteService: AutocompleteService = .disabled

        /// The callout service to use.
        public lazy var calloutService: CalloutService = Callouts.StandardService(
            keyboardContext: state.keyboardContext,
            feedbackService: feedbackService
        ) {
            didSet { setupCalloutContextForServices() }
        }

        /// The dictation service to use.
        public lazy var dictationService: KeyboardDictationService = .disabled(
            context: state.dictationContext
        )

        /// The feedback service to use.
        public lazy var feedbackService: FeedbackService = Feedback.StandardService()

        /// The keyboard behavior to use.
        public lazy var keyboardBehavior: KeyboardBehavior = Keyboard.StandardBehavior(
            keyboardContext: state.keyboardContext,
            repeatGestureTimer: repeatGestureTimer
        )

        /// The keyboard layout service to use.
        public lazy var layoutService: KeyboardLayoutService = KeyboardLayout.StandardService() {
            didSet { state.keyboardContext.triggerKeyboardViewRefresh() }
        }

        /// The shared repeat gesture timer.
        public lazy var repeatGestureTimer = GestureButtonTimer()

        /// The space drag gesture handler to use.
        public lazy var spaceDragGestureHandler = Gestures.SpaceDragGestureHandler(
            sensitivity: .medium,
            action: { _ in }
        )

        /// The keyboard style provider to use.
        public lazy var styleProvider: KeyboardStyleProvider = KeyboardStyle.StandardProvider(
            keyboardContext: state.keyboardContext
        )


        // MARK: - Deprecated

        @available(*, deprecated, renamed: "autocompleteService")
        public var autocompleteProvider: AutocompleteService {
            get { autocompleteService }
            set { autocompleteService = newValue }
        }

        @available(*, deprecated, renamed: "calloutService")
        public var calloutActionProvider: CalloutService {
            get { calloutService }
            set { calloutService = newValue }
        }

        @available(*, deprecated, renamed: "layoutService")
        public var layoutProvider: KeyboardLayoutService {
            get { layoutService }
            set { layoutService = newValue }
        }
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
        weak var weakController = controller
        (actionHandler as? KeyboardAction.StandardHandler)?.keyboardController = weakController
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
        let context = state.calloutContext.actionContext
        context.service = calloutService
        context.tapAction = { [weak self] action in
            self?.actionHandler.handle(.release, on: action)
        }
    }
}
