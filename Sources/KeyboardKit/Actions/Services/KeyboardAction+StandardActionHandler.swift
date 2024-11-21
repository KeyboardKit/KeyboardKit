//
//  KeyboardAction+StandardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardActionHandler where Self == KeyboardAction.StandardActionHandler {

    /// Create a standard action handler.
    ///
    /// - Parameters:
    ///   - controller: The keyboard controller to use.
    static func standard(
        for controller: KeyboardController
    ) -> Self {
        KeyboardAction.StandardActionHandler(
            controller: controller
        )
    }

    /// Create a standard action handler.
    ///
    /// The `controller` parameter is optional, to allow you
    /// to set up later.
    ///
    /// - Parameters:
    ///   - controller: The keyboard controller to use, if any.
    ///   - keyboardContext: A custom keyboard context.
    ///   - keyboardBehavior: A custom keyboard behavior.
    ///   - autocompleteContext: A custom autocomplete context.
    ///   - autocompleteService: A custom autocomplete service.
    ///   - feedbackContext: A custom feedback context.
    ///   - feedbackService: A custom feedback service.
    ///   - spaceDragGestureHandler: A custom space gesture handler.
    static func standard(
        for controller: KeyboardController?,
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        autocompleteService: AutocompleteService,
        feedbackContext: KeyboardFeedbackContext,
        feedbackService: KeyboardFeedbackService,
        spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
    ) -> Self {
        KeyboardAction.StandardActionHandler(
            controller: controller,
            keyboardContext: keyboardContext,
            keyboardBehavior: keyboardBehavior,
            autocompleteContext: autocompleteContext,
            autocompleteService: autocompleteService,
            feedbackContext: feedbackContext,
            feedbackService: feedbackService,
            spaceDragGestureHandler: spaceDragGestureHandler
        )
    }
}

extension KeyboardAction {

    /// This class provides a standard way to handle actions
    /// that are triggered by the keyboard.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// The handler implements ``KeyboardBehavior`` by using
    /// the ``behavior`` by default, but it can override any
    /// of these standard behaviors. For instance, the class
    /// defines even more `should` functions for the various
    /// corresponding `try` functions, which lets you easily
    /// override both *if* something should be performed and
    /// if so, *how* to perform it.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// This service can also be resolved with the shorthand
    /// ``KeyboardActionHandler/standard(for:)``.
    ///
    /// See <doc:Actions-Article> for more information.
    open class StandardActionHandler: NSObject, KeyboardActionHandler, KeyboardBehavior {

        // MARK: - Initialization

        /// Create a standard keyboard action handler for an
        /// explicit controller.
        ///
        /// - Parameters:
        ///   - controller: The keyboard controller to use.
        public init(
            controller: KeyboardController
        ) {
            let state = controller.state
            let services = controller.services
            weak var weakController = controller
            self.keyboardController = weakController
            self.keyboardContext = state.keyboardContext
            self.behavior = services.keyboardBehavior
            self.autocompleteContext = state.autocompleteContext
            self.autocompleteService = services.autocompleteService
            self.feedbackContext = state.feedbackContext
            self.feedbackService = services.feedbackService
            self.spaceDragGestureHandler = services.spaceDragGestureHandler
        }

        /// Create a standard keyboard action handler for an
        /// optional controller and explicit dependencies.
        ///
        /// The `controller` parameter is optional, to allow
        /// you to set up later.
        ///
        /// - Parameters:
        ///   - controller: The keyboard controller to use, if any.
        ///   - keyboardContext: A custom keyboard context.
        ///   - keyboardBehavior: A custom keyboard behavior.
        ///   - autocompleteContext: A custom autocomplete context.
        ///   - autocompleteService: A custom autocomplete service.
        ///   - feedbackContext: A custom feedback context.
        ///   - feedbackService: A custom feedback service.
        ///   - spaceDragGestureHandler: A custom space gesture handler.
        public init(
            controller: KeyboardController?,
            keyboardContext: KeyboardContext,
            keyboardBehavior: KeyboardBehavior,
            autocompleteContext: AutocompleteContext,
            autocompleteService: AutocompleteService,
            feedbackContext: KeyboardFeedbackContext,
            feedbackService: KeyboardFeedbackService,
            spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
        ) {
            weak var weakController = controller
            self.keyboardController = weakController
            self.keyboardContext = keyboardContext
            self.behavior = keyboardBehavior
            self.autocompleteContext = autocompleteContext
            self.autocompleteService = autocompleteService
            self.feedbackContext = feedbackContext
            self.feedbackService = feedbackService
            self.spaceDragGestureHandler = spaceDragGestureHandler
        }
        
        
        // MARK: - Properties
        
        /// The controller to which this handler applies.
        public weak var keyboardController: KeyboardController?
        
        
        /// The autocomplete context to use.
        public var autocompleteContext: AutocompleteContext
        
        /// The autocomplete service to use.
        public var autocompleteService: AutocompleteService?
        
        /// The keyboard behavior to use.
        public var behavior: KeyboardBehavior
        
        /// The keyboard context to use.
        public var keyboardContext: KeyboardContext
        
        /// The feedback context to use.
        public var feedbackContext: KeyboardFeedbackContext

        /// The feedback service to use.
        public var feedbackService: KeyboardFeedbackService

        /// The space drag gesture handler to use.
        public var spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
        
        
        private var spaceDragActivationLocation: CGPoint?
        
        
        // MARK: - KeyboardActionHandler
        
        /// Whether the handler can handle an action gesture.
        open func canHandle(
            _ gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            self.action(for: gesture, on: action) != nil
        }
        
        /// Handle a certain keyboard action.
        open func handle(
            _ action: KeyboardAction
        ) {
            action.standardAction?(keyboardController)
        }
        
        /// Handle a certain keyboard action gesture.
        open func handle(
            _ gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            handle(gesture, on: action, replaced: false)
        }
        
        /// Handle a certain action gesture, with replace logic.
        open func handle(
            _ gesture: Keyboard.Gesture,
            on action: KeyboardAction,
            replaced: Bool
        ) {
            if !replaced && tryHandleReplacementAction(before: gesture, on: action) { return }
            let gestureAction = self.action(for: gesture, on: action)
            tryTriggerFeedback(for: gesture, on: action)
            tryUpdateSpaceDragState(for: gesture, on: action)
            guard let gestureAction else { return }
            tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
            tryAutocompleteIgnoreCurrentWord(before: gesture, on: action)
            tryApplyAutocorrectSuggestion(before: gesture, on: action)
            gestureAction(keyboardController)
            tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
            tryEndCurrentSentence(after: gesture, on: action)
            tryChangeKeyboardCase(after: gesture, on: action)
            tryChangeKeyboardType(after: gesture, on: action)
            tryPerformAutocomplete(after: gesture, on: action)
            tryRegisterEmoji(after: gesture, on: action)
        }
        
        /// Handle a certain autocomplete suggestion.
        open func handle(
            _ suggestion: Autocomplete.Suggestion
        ) {
            tryAutolearnSuggestion(suggestion)
            keyboardContext.insertAutocompleteSuggestion(suggestion)
            handle(.release, on: .character(""))
        }
        
        /// Handle a certain keyboard action drag gesture.
        open func handleDrag(
            on action: KeyboardAction,
            from startLocation: CGPoint,
            to currentLocation: CGPoint
        ) {
            tryHandleSpaceDrag(
                on: action,
                from: startLocation,
                to: currentLocation
            )
        }
        
        
        // MARK: - KeyboardBehavior
        
        open var backspaceRange: Keyboard.BackspaceRange {
            behavior.backspaceRange
        }
        
        open var endSentenceText: String {
            get { behavior.endSentenceText }
            set { behavior.endSentenceText = newValue }
        }

        open func preferredKeyboardCase(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Keyboard.KeyboardCase {
            behavior.preferredKeyboardCase(after: gesture, on: action)
        }

        open func preferredKeyboardType(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Keyboard.KeyboardType {
            behavior.preferredKeyboardType(after: gesture, on: action)
        }

        open func shouldEndCurrentSentence(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            behavior.shouldEndCurrentSentence(after: gesture, on: action)
        }
        
        open func shouldRegisterEmoji(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            behavior.shouldRegisterEmoji(after: gesture, on: action)
        }


        // MARK: - Try Functionality

        /// Try to change keyboard case after a certain action gesture.
        open func tryChangeKeyboardCase(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            let new = preferredKeyboardCase(after: gesture, on: action)
            guard keyboardContext.keyboardCase != new else { return }
            keyboardContext.keyboardCase = new
        }

        /// Try to change keyboard type after a certain action gesture.
        open func tryChangeKeyboardType(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            let new = preferredKeyboardType(after: gesture, on: action)
            guard keyboardContext.keyboardType != new else { return }
            keyboardContext.keyboardType = new
        }

        /// Try to end the current sentence after a certain action gesture.
        open func tryEndCurrentSentence(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldEndCurrentSentence(after: gesture, on: action) else { return }
            let text = behavior.endSentenceText
            keyboardController?.endSentence(withText: text)
        }

        /// Try to register an emoji after a certain action gesture.
        open func tryRegisterEmoji(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldRegisterEmoji(after: gesture, on: action) else { return }
            switch action {
            case .emoji(let emoji): EmojiCategory.addEmoji(emoji, to: .frequent, maxCount: 30)
            default: return
            }
        }


        // MARK: - Actions

        /// The standard action to use for a gesture action.
        open func action(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> KeyboardAction.GestureAction? {
            let standard = action.standardAction(for: gesture)
            guard action == .space, gesture == .release else { return standard }
            let isSpaceDragActive = keyboardContext.isSpaceDragGestureActive
            return isSpaceDragActive ? nil : standard
        }

        /// An optional keyboard action gesture replacement.
        open func replacementAction(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> KeyboardAction? {
            guard gesture == .release else { return nil }

            // Apply proxy-based replacements, if any
            if case let .character(char) = action,
               let replacement = keyboardContext.preferredQuotationReplacement(
                whenInserting: char,
                for: keyboardContext.locale) {
                return .character(replacement)
            }

            // Apply Kurdish replacements, if any
            if keyboardContext.locale.identifier.hasPrefix("ckb") && action == .character("ھ") {
                return .character("ه")
            }

            return nil
        }

        /// Try to handle a replacement action before a certain action gesture.
        ///
        /// The caller shouldn't handle the action when this returns `true`.
        open func tryHandleReplacementAction(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            guard let action = replacementAction(for: gesture, on: action) else { return false }
            handle(.release, on: action, replaced: true)
            return true
        }


        // MARK: - Autocomplete

        /// Whether to apply autocorrect before a certain gesture action.
        open func shouldApplyAutocorrectSuggestion(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            if isSpaceCursorDrag(action) { return false }
            if keyboardContext.isCursorAtNewWord { return false }
            guard gesture == .release else { return false }
            return action.shouldApplyAutocorrectSuggestion
        }

        /// Whether to ignore autocorrections for the current word before a certain gesture action.
        open func shouldAutoIgnoreCurrentWord(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            guard autocompleteContext.settings.isAutolearnEnabled else { return false }
            guard gesture == .press, action == .backspace else { return false }
            #if os(iOS) || os(tvOS) || os(visionOS)
            let proxy = keyboardContext.textDocumentProxy
            guard let word = proxy.currentWordPreCursorPart, !word.isEmpty else { return false }
            let isDeletingAutocorrection = word == lastAutocorrectedWord
            lastAutocorrectedWord = nil
            if isDeletingAutocorrection { return true }
            #endif
            return autocompleteContext.suggestions.contains { $0.isAutocorrect }
        }

        /// Whether to auto-learn a certain suggestion.
        open func shouldAutolearnSuggestion(
            _ suggestion: Autocomplete.Suggestion
        ) -> Bool {
            guard autocompleteContext.settings.isAutolearnEnabled else { return false }
            return suggestion.isUnknown && !suggestion.text.isEmpty
        }

        /// Whether to perform autocomplete after a certain gesture action.
        open func shouldPerformAutocomplete(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            gesture == .release
        }

        /// Whether to reinsert an autocomplete removed space after a certain gesture action.
        open func shouldReinsertAutocompleteRemovedSpace(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            gesture == .release && action.shouldReinsertAutocompleteInsertedSpace
        }

        /// Whether to remove an autocomplete inserted space after a certain gesture action.
        open func shouldRemoveAutocompleteInsertedSpace(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            gesture == .release && action.shouldRemoveAutocompleteInsertedSpace
        }

        /// Temporary state used to auto-ignore when correcting an autocompleted word.
        private var lastAutocorrectedWord: String?

        /// Try to apply autocorrect before a certain gesture action.
        open func tryApplyAutocorrectSuggestion(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldApplyAutocorrectSuggestion(before: gesture, on: action) else { return }
            let suggestions = autocompleteContext.suggestions
            let autocorrect = suggestions.first { $0.isAutocorrect }
            guard let suggestion = autocorrect else { return }
            lastAutocorrectedWord = suggestion.text
            keyboardContext.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        }

        /// Try to ignore autocorrections for the current word before a certain gesture action.
        open func tryAutocompleteIgnoreCurrentWord(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldAutoIgnoreCurrentWord(before: gesture, on: action) else { return }
            #if os(iOS) || os(tvOS) || os(visionOS)
            let proxy = keyboardContext.textDocumentProxy
            guard let word = proxy.currentWordPreCursorPart else { return }
            autocompleteService?.ignoreWord(word)
            #endif
        }

        /// Try to auto-learn a certain suggestion.
        open func tryAutolearnSuggestion(
            _ suggestion: Autocomplete.Suggestion
        ) {
            guard shouldAutolearnSuggestion(suggestion) else { return }
            autocompleteService?.learn(suggestion)
        }

        /// Try to perform autocomplete after a certain gesture action.
        open func tryPerformAutocomplete(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldPerformAutocomplete(after: gesture, on: action) else { return }
            keyboardController?.performAutocomplete()
        }

        /// Try to reinsert an autocomplete removed space after a certain gesture action.
        open func tryReinsertAutocompleteRemovedSpace(
            after gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldReinsertAutocompleteRemovedSpace(after: gesture, on: action) else { return }
            keyboardContext.tryReinsertAutocompleteRemovedSpace()
        }

        /// Try to remove inserted space before a certain gesture action.
        open func tryRemoveAutocompleteInsertedSpace(
            before gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldRemoveAutocompleteInsertedSpace(before: gesture, on: action) else { return }
            keyboardContext.tryRemoveAutocompleteInsertedSpace()
        }


        // MARK: - Feedback

        /// The audio feedback to use for an action gesture.
        open func audioFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> KeyboardFeedback.Audio? {
            let config = feedbackContext.audioConfiguration
            let custom = config.customFeedback(for: gesture, on: action)
            if let custom = custom { return custom }
            if action == .space && gesture == .longPress { return nil }
            if action == .backspace && gesture == .press { return config.delete }
            if action == .backspace && gesture == .repeatPress { return config.delete }
            if action.isInputAction && gesture == .press { return config.input }
            if action.isSystemAction && gesture == .press { return config.system }
            return nil
        }

        /// The haptic feedback to use for an action gesture.
        open func hapticFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> KeyboardFeedback.Haptic? {
            let config = feedbackContext.hapticConfiguration
            return config.feedback(for: gesture, on: action)
        }

        /// Whether to trigger feedback for an action.
        ///
        /// This always returns `true` to allow the class to
        /// perform more granular checks later.
        open func shouldTriggerFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            return true
        }

        /// Whether to trigger audio feedback for an action.
        ///
        /// This returns true if the ``feedbackContext`` has
        /// audio feedback enabled in it's settings.
        open func shouldTriggerAudioFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            feedbackContext.settings.isAudioFeedbackEnabled
        }

        /// Whether to trigger haptic feedback for an action.
        ///
        /// This returns true if the ``feedbackContext`` has
        /// haptic feedback enabled in it's settings, and if
        /// certain other gesture conditions are `true`. The
        /// function also always returns true for long press
        /// on space by default.
        open func shouldTriggerHapticFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) -> Bool {
            if action == .space && gesture == .longPress { return true }
            guard feedbackContext.settings.isHapticFeedbackEnabled else { return false }
            let hasRelease = self.action(for: .release, on: action) != nil
            if gesture == .press && hasRelease { return true }
            let hasAction = self.action(for: gesture, on: action) != nil
            if gesture != .release && hasAction { return true }
            let config = feedbackContext.hapticConfiguration
            return config.hasCustomFeedback(for: gesture, on: action)
        }

        /// Trigger a certain audio feedback.
        open func triggerAudioFeedback(_ feedback: KeyboardFeedback.Audio) {
            feedbackService.triggerAudioFeedback(feedback)
        }

        /// Trigger a certain haptic feedback.
        open func triggerHapticFeedback(_ feedback: KeyboardFeedback.Haptic) {
            feedbackService.triggerHapticFeedback(feedback)
        }

        /// Try to trigger audio and haptic feedback for the
        /// provided gesture action.
        open func tryTriggerFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            guard shouldTriggerFeedback(for: gesture, on: action) else { return }
            tryTriggerAudioFeedback(for: gesture, on: action)
            tryTriggerHapticFeedback(for: gesture, on: action)
        }

        /// Try to trigger audio feedback for the action.
        open func tryTriggerAudioFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            if !shouldTriggerAudioFeedback(for: gesture, on: action) { return }
            guard let feedback = audioFeedback(for: gesture, on: action) else { return }
            triggerAudioFeedback(feedback)
        }

        /// Try to trigger haptic feedback for the action.
        open func tryTriggerHapticFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            if !shouldTriggerHapticFeedback(for: gesture, on: action) { return }
            guard let feedback = hapticFeedback(for: gesture, on: action) else { return }
            triggerHapticFeedback(feedback)
        }

        /// Trigger feedback for a certain action gesture.
        open func triggerFeedback(
            for gesture: Keyboard.Gesture,
            on action: KeyboardAction
        ) {
            tryTriggerFeedback(for: gesture, on: action)
        }
    }
}

private extension KeyboardAction.StandardActionHandler {

    func isSpaceCursorDrag(_ action: KeyboardAction) -> Bool {
        guard action == .space else { return false }
        let handler = spaceDragGestureHandler
        return handler.currentDragTextPositionOffset != 0
    }

    func tryHandleSpaceDrag(
        on action: KeyboardAction,
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    ) {
        guard action == .space else { return }
        guard keyboardContext.spaceLongPressBehavior == .moveInputCursor else { return }
        guard keyboardContext.isSpaceDragGestureActive else { return }
        let activationLocation = spaceDragActivationLocation ?? currentLocation
        spaceDragActivationLocation = activationLocation
        spaceDragGestureHandler.handleDragGesture(
            from: activationLocation,
            to: currentLocation
        )
    }

    func tryUpdateSpaceDragState(
        for gesture: Keyboard.Gesture,
        on action: KeyboardAction
    ) {
        guard action == .space else { return }
        switch gesture {
        case .press:
            setSpaceDragActive(false)
            spaceDragActivationLocation = nil
        case .longPress:
            setSpaceDragActive(true)
        case .release, .end:
            setSpaceDragActive(false)
        default: break
        }
    }

    func setSpaceDragActive(_ isActive: Bool) {
        keyboardContext.setIsSpaceDragGestureActive(
            isActive,
            animated: true
        )
    }
}
