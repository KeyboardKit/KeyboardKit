//
//  KeyboardAction+StandardHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

import Foundation

extension KeyboardAction {
    
    /// This class provides a standard way to handle actions
    /// that are triggered by the keyboard.
    ///
    /// KeyboardKit automatically creates an instance of the
    /// class when the keyboard is launched, then injects it
    /// into ``KeyboardInputViewController/services``.
    ///
    /// You can inherit this class to get base functionality,
    /// then override any open parts that you want to change.
    ///
    /// See <doc:Actions-Article> for more information.
    open class StandardHandler: NSObject, KeyboardActionHandler {
        
        // MARK: - Initialization
        
        #if os(iOS)
        /// Create a standard keyboard action handler for an
        /// input controller.
        ///
        /// - Parameters:
        ///   - controller: The keyboard input controller to use.
        public convenience init(
            controller: KeyboardInputViewController
        ) {
            self.init(
                controller: controller,
                keyboardContext: controller.state.keyboardContext,
                keyboardBehavior: controller.services.keyboardBehavior,
                autocompleteContext: controller.state.autocompleteContext,
                feedbackContext: controller.state.feedbackContext,
                spaceDragGestureHandler: controller.services.spaceDragGestureHandler
            )
        }
        #endif
        
        /// Create a standard keyboard action handler with a
        /// separate set of services.
        ///
        /// - Parameters:
        ///   - controller: The keyboard controller to use, if any.
        ///   - keyboardContext: The keyboard context to use.
        ///   - keyboardBehavior: The keyboard behavior to use.
        ///   - autocompleteContext: The autocomplete context to use.
        ///   - feedbackContext: The feedback configuration to use.
        ///   - spaceDragGestureHandler: The space gesture handler to use.
        public init(
            controller: KeyboardController?,
            keyboardContext: KeyboardContext,
            keyboardBehavior: KeyboardBehavior,
            autocompleteContext: AutocompleteContext,
            feedbackContext: FeedbackContext,
            spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
        ) {
            weak var weakController = controller
            self.keyboardController = weakController
            self.keyboardContext = keyboardContext
            self.keyboardBehavior = keyboardBehavior
            self.autocompleteContext = autocompleteContext
            self.feedbackContext = feedbackContext
            self.spaceDragGestureHandler = spaceDragGestureHandler
        }
        
        
        // MARK: - Properties
        
        /// The controller to which this handler applies.
        public weak var keyboardController: KeyboardController?
        
        
        /// The autocomplete context to use.
        public var autocompleteContext: AutocompleteContext
        
        /// The keyboard behavior to use.
        public var keyboardBehavior: KeyboardBehavior
        
        /// The keyboard context to use.
        public var keyboardContext: KeyboardContext
        
        /// The feedback configuration to use.
        public var feedbackContext: FeedbackContext
        
        /// The space drag gesture handler to use.
        public var spaceDragGestureHandler: Gestures.SpaceDragGestureHandler
        
        
        /// The action to use to register emojis, if any.
        public var emojiRegistrationAction: ((Emoji) -> Void)?
        
        
        private var spaceDragActivationLocation: CGPoint?
        
        
        
        // MARK: - KeyboardActionHandler
        
        /// Whether the handler can handle an action gesture.
        open func canHandle(
            _ gesture: Gesture,
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
            _ gesture: Gesture,
            on action: KeyboardAction
        ) {
            handle(gesture, on: action, replaced: false)
        }
        
        /// Handle a certain autocomplete suggestion.
        open func handle(
            _ suggestion: Autocomplete.Suggestion
        ) {
            keyboardContext.insertAutocompleteSuggestion(suggestion)
            handle(.release, on: .character(""))
        }
        
        /// Handle a certain action gesture, with replace logic.
        open func handle(
            _ gesture: Gesture,
            on action: KeyboardAction,
            replaced: Bool
        ) {
            if !replaced && tryHandleReplacementAction(before: gesture, on: action) { return }
            let gestureAction = self.action(for: gesture, on: action)
            triggerFeedback(for: gesture, on: action)
            tryUpdateSpaceDragState(for: gesture, on: action)
            guard let gestureAction else { return }
            tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
            tryApplyAutocorrectSuggestion(before: gesture, on: action)
            gestureAction(keyboardController)
            tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
            tryEndSentence(after: gesture, on: action)
            tryChangeKeyboardType(after: gesture, on: action)
            tryPerformAutocomplete(after: gesture, on: action)
            tryRegisterEmoji(after: gesture, on: action)
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
        
        /// Trigger feedback for a certain action gesture.
        open func triggerFeedback(
            for gesture: Gesture,
            on action: KeyboardAction
        ) {
            guard shouldTriggerFeedback(for: gesture, on: action) else { return }
            triggerAudioFeedback(for: gesture, on: action)
            triggerHapticFeedback(for: gesture, on: action)
        }
        
        
        
        // MARK: - Feedback
        
        /// The feedback to use for a certain action gesture.
        open func audioFeedback(
            for gesture: Gesture,
            on action: KeyboardAction
        ) -> Feedback.Audio? {
            let config = feedbackContext.audio
            let custom = config.feedback(for: gesture, on: action)
            if let custom = custom { return custom.feedback }
            if action == .space && gesture == .longPress { return nil }
            if action == .backspace { return config.delete }
            if action.isInputAction { return config.input }
            if action.isSystemAction { return config.system }
            return nil
        }
        
        /// The feedback to use for a certain action gesture.
        open func hapticFeedback(
            for gesture: Gesture,
            on action: KeyboardAction
        ) -> Feedback.Haptic? {
            let config = feedbackContext.haptic
            let custom = config.feedback(for: gesture, on: action)
            if let custom = custom { return custom.feedback }
            if action == .space && gesture == .longPress { return config.longPressOnSpace }
            return config.feedback(for: gesture)
        }
        
        /// Trigger feedback for a certain action gesture.
        open func triggerAudioFeedback(
            for gesture: Gesture,
            on action: KeyboardAction
        ) {
            let feedback = audioFeedback(for: gesture, on: action)
            feedback?.trigger()
        }
        
        /// Trigger feedback for a certain action gesture.
        open func triggerHapticFeedback(
            for gesture: Gesture,
            on action: KeyboardAction
        ) {
            let feedback = hapticFeedback(for: gesture, on: action)
            feedback?.trigger()
        }
        
        
        // MARK: - Open Functions
        
        /// The standard action to use for a gesture action.
        open func action(
            for gesture: Gesture,
            on action: KeyboardAction
        ) -> KeyboardAction.GestureAction? {
            let standard = action.standardAction(for: gesture)
            if action != .space && gesture != .release { return standard }
            let isSpaceDragActive = keyboardContext.isSpaceDragGestureActive
            return isSpaceDragActive ? nil : standard
        }
        
        /// An optional keyboard action gesture replacement.
        open func replacementAction(
            for gesture: Gesture,
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
        
        /// Whether to trigger feedback for a gesture action.
        open func shouldTriggerFeedback(for gesture: Gesture, on action: KeyboardAction) -> Bool {
            if gesture == .press && self.action(for: .release, on: action) != nil { return true }
            if gesture != .release && self.action(for: gesture, on: action) != nil { return true }
            return false
        }
        
        /// Whether to apply autocorrect before an action.
        open func tryApplyAutocorrectSuggestion(
            before gesture: Gesture,
            on action: KeyboardAction
        ) {
            if isSpaceCursorDrag(action) { return }
            if keyboardContext.isCursorAtNewWord { return }
            guard gesture == .release else { return }
            guard action.shouldApplyAutocorrectSuggestion else { return }
            let suggestions = autocompleteContext.suggestions
            let autocorrect = suggestions.first { $0.isAutocorrect }
            guard let suggestion = autocorrect else { return }
            keyboardContext.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
        }
        
        /// Try to change keyboard type after a gesture.
        open func tryChangeKeyboardType(
            after gesture: Gesture,
            on action: KeyboardAction
        ) {
            guard keyboardBehavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action) else { return }
            let newType = keyboardBehavior.preferredKeyboardType(after: gesture, on: action)
            keyboardContext.keyboardType = newType
        }
        
        /// Try to end the current sentence after a gesture.
        open func tryEndSentence(
            after gesture: Gesture,
            on action: KeyboardAction
        ) {
            guard keyboardBehavior.shouldEndSentence(after: gesture, on: action) else { return }
            keyboardContext.endSentence()
        }
        
        /// Try to perform autocomplete after a gesture.
        open func tryPerformAutocomplete(
            after gesture: Gestures.KeyboardGesture,
            on action: KeyboardAction
        ) {
            keyboardController?.performAutocomplete()
        }
        
        /// Try to register an emoji after a gesture.
        open func tryRegisterEmoji(
            after gesture: Gestures.KeyboardGesture,
            on action: KeyboardAction
        ) {
            guard gesture == .release else { return }
            switch action {
            case .emoji(let emoji): emojiRegistrationAction?(emoji)
            default: return
            }
        }
        
        /// Handle a replacement action before a gesture.
        ///
        /// The caller shouldn't handle the action when this
        /// function returns `true`.
        open func tryHandleReplacementAction(
            before gesture: Gesture,
            on action: KeyboardAction
        ) -> Bool {
            guard let action = replacementAction(for: gesture, on: action) else { return false }
            handle(.release, on: action, replaced: true)
            return true
        }
        
        /// Try to reinsert removed space after a gesture.
        ///
        /// This is used to handle autocomplete space insert.
        open func tryReinsertAutocompleteRemovedSpace(after gesture: Gesture, on action: KeyboardAction) {
            guard gesture == .release else { return }
            guard action.shouldReinsertAutocompleteInsertedSpace else { return }
            keyboardContext.tryReinsertAutocompleteRemovedSpace()
        }
        
        /// Try to remove inserted space before a gesture.
        ///
        /// This is used to handle autocomplete space insert.
        open func tryRemoveAutocompleteInsertedSpace(before gesture: Gesture, on action: KeyboardAction) {
            guard gesture == .release else { return }
            guard action.shouldRemoveAutocompleteInsertedSpace else { return }
            keyboardContext.tryRemoveAutocompleteInsertedSpace()
        }
    }
}

private extension KeyboardAction.StandardHandler {
    
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
        for gesture: Gesture,
        on action: KeyboardAction
    ) {
        guard action == .space else { return }
        switch gesture {
        case .press:
            setSpaceDragActive(false)
            spaceDragActivationLocation = nil
        case .longPress:
            setSpaceDragActive(true)
        case .release:
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
