//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This standard keyboard action handler is used by default by
 KeyboardKit and provides a standard way of handling actions.

 You can inherit this class and override any open properties
 and functions to customize the standard behavior. It uses a
 ``KeyboardBehavior`` for some behavioral decisions.

 Note that the ``keyboardController`` reference is `weak` to
 avoid a retain cycle.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {


    // MARK: - Initialization

    /**
     Create a standard keyboard action handler, using a view
     controller to setup all dependencies.

     - Parameters:
       - inputViewController: The view controller to use.
       - spaceDragGestureHandler: A custom space drag gesture handler to use, if any.
       - spaceDragSensitivity: The space drag sensitivity to use, by default ``SpaceDragSensitivity/medium``.
     */
    public init(
        inputViewController ivc: KeyboardInputViewController,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium
    ) {
        weak var controller = ivc
        self.keyboardController = controller
        self.autocompleteContext = ivc.autocompleteContext
        self.keyboardBehavior = ivc.keyboardBehavior
        self.keyboardContext = ivc.keyboardContext
        self.keyboardFeedbackSettings = ivc.keyboardFeedbackSettings
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? Self.dragGestureHandler(
            keyboardController: ivc,
            keyboardContext: ivc.keyboardContext,
            spaceDragSensitivity: spaceDragSensitivity
        )
    }

    /**
     Create a standard keyboard action handler.

     - Parameters:
       - keyboardController: The keyboard controller to use.
       - keyboardContext: The keyboard context to use.
       - keyboardBehavior: The keyboard behavior to use.
       - keyboardFeedbackSettings: The keyboard feedback settings to use.
       - autocompleteContext: The autocomplete context to use.
       - spaceDragGestureHandler: A custom space drag gesture handler, if any.
       - spaceDragSensitivity: The space drag sensitivity to use, by default ``SpaceDragSensitivity/medium``.
     */
    public init(
        keyboardController: KeyboardController,
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        keyboardFeedbackSettings: KeyboardFeedbackSettings,
        autocompleteContext: AutocompleteContext,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium
    ) {
        weak var controller = keyboardController
        self.keyboardController = controller
        self.autocompleteContext = autocompleteContext
        self.keyboardBehavior = keyboardBehavior
        self.keyboardContext = keyboardContext
        self.keyboardFeedbackSettings = keyboardFeedbackSettings
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? Self.dragGestureHandler(
            keyboardController: keyboardController,
            keyboardContext: keyboardContext,
            spaceDragSensitivity: spaceDragSensitivity
        )
    }

    static func dragGestureHandler(
        keyboardController: KeyboardController,
        keyboardContext: KeyboardContext,
        spaceDragSensitivity: SpaceDragSensitivity
    ) -> SpaceCursorDragGestureHandler {
        weak var controller = keyboardController
        weak var context = keyboardContext
        return .init(
            sensitivity: spaceDragSensitivity,
            action: {
                let offset = context?.textDocumentProxy.spaceDragOffset(for: $0)
                controller?.adjustTextPosition(byCharacterOffset: offset ?? $0)
            }
        )
    }


    // MARK: - Properties

    public weak var keyboardController: KeyboardController?

    public let autocompleteContext: AutocompleteContext
    public let keyboardBehavior: KeyboardBehavior
    public let keyboardContext: KeyboardContext
    public let keyboardFeedbackSettings: KeyboardFeedbackSettings
    public let spaceDragGestureHandler: DragGestureHandler

    public var textDocumentProxy: UITextDocumentProxy { keyboardContext.textDocumentProxy }

    private var isSpaceDragGestureActive = false
    private var spaceDragActivationLocation: CGPoint?


    // MARK: - KeyboardActionHandler

    /**
     Whether or not the handler can handle a certain gesture
     on a certain action.
     */
    open func canHandle(
        _ gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> Bool {
        self.action(for: gesture, on: action) != nil
    }

    /**
     Handle a keyboard action using its standard action.
     */
    public func handle(
        _ action: KeyboardAction
    ) {
        action.standardAction?(keyboardController)
    }

    /**
     Handle a certain keyboard action gesture.
     */
    open func handle(
        _ gesture: KeyboardGesture,
        on action: KeyboardAction
    ) {
        handle(gesture, on: action, replaced: false)
    }

    /**
     Handle a certain keyboard action gesture.

     This function is used to handle a case where the action
     can be triggered as a replacement of another operation.
     */
    open func handle(
        _ gesture: KeyboardGesture,
        on action: KeyboardAction,
        replaced: Bool
    ) {
        if !replaced && tryHandleReplacementAction(before: gesture, on: action) { return }
        triggerFeedback(for: gesture, on: action)
        tryUpdateSpaceDragState(for: gesture, on: action)
        guard let gestureAction = self.action(for: gesture, on: action) else { return }
        tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
        tryApplyAutocompleteSuggestion(before: gesture, on: action)
        gestureAction(keyboardController)
        tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
        tryEndSentence(after: gesture, on: action)
        tryChangeKeyboardType(after: gesture, on: action)
        keyboardController?.performAutocomplete()
        keyboardController?.performTextContextSync()
    }

    /**
     Handle a drag gesture on a certain keyboard action.
     */
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
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) {
        guard shouldTriggerFeedback(for: gesture, on: action) else { return }
        triggerAudioFeedback(for: gesture, on: action)
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    
    
    // MARK: - Feedback

    /**
     The audio feedback to use for a certain action gesture.
     */
    open func audioFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> AudioFeedback? {
        let config = keyboardFeedbackSettings.audioConfiguration
        let custom = config.actions.first { $0.action == action }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return nil }
        if action == .backspace { return config.delete }
        if action.isInputAction { return config.input }
        if action.isSystemAction { return config.system }
        return nil
    }
    
    /**
     The haptic feedback to use for a certain action gesture.
     */
    open func hapticFeedback(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> HapticFeedback? {
        let config = keyboardFeedbackSettings.hapticConfiguration
        let custom = config.actions.first { $0.action == action && $0.gesture == gesture }
        if let custom = custom { return custom.feedback }
        if action == .space && gesture == .longPress { return config.longPressOnSpace }
        switch gesture {
        case .doubleTap: return config.doubleTap
        case .longPress: return config.longPress
        case .press: return config.press
        case .release: return config.release
        case .repeatPress: return config.repeat
        }
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = audioFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
    
    /**
     Trigger feedback for a certain keyboard action gesture.
     */
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        let feedback = hapticFeedback(for: gesture, on: action)
        feedback?.trigger()
    }
    

    // MARK: - Open Functions

    /**
     This is the standard action that is used by the handler
     when a gesture is performed on a certain action.
     */
    open func action(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) -> KeyboardAction.GestureAction? {
        action.standardAction(for: gesture)
    }

    /**
     Try to resolve a replacement action before a gesture is
     performed on the provided action.
     */
    open func replacementAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        guard gesture == .release else { return nil }

        // Apply proxy-based replacements, if any
        if case let .character(char) = action,
           let replacement = textDocumentProxy.preferredQuotationReplacement(
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

    /**
     Whether or not a feedback should be given for a certain
     gesture on a certain action.
     */
    open func shouldTriggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        if gesture == .press && self.action(for: .release, on: action) != nil { return true }
        if gesture != .release && self.action(for: gesture, on: action) != nil { return true }
        return false
    }

    /**
     Try to apply an `isAutocomplete` autocomplete suggesion
     before the `gesture` has been performed on the `action`.
     */
    open func tryApplyAutocompleteSuggestion(before gesture: KeyboardGesture, on action: KeyboardAction) {
        if isSpaceCursorDrag(action) { return }
        if textDocumentProxy.isCursorAtNewWord { return }
        guard gesture == .release else { return }
        guard action.shouldApplyAutocorrectSuggestion else { return }
        guard let suggestion = (autocompleteContext.suggestions.first { $0.isAutocorrect }) else { return }
        textDocumentProxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
    }

    /**
     Try to change `keyboardType` after a `gesture` has been
     performed on the provided `action`.
     */
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action) else { return }
        let newType = keyboardBehavior.preferredKeyboardType(after: gesture, on: action)
        keyboardContext.keyboardType = newType
    }

    /**
     Try to end the current sentence after the `gesture` has
     been performed on the provided `action`.
     */
    open func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldEndSentence(after: gesture, on: action) else { return }
        textDocumentProxy.endSentence()
    }

    /**
     Try to resolve and handle a replacement keyboard action
     before the `gesture` is performed on the `action`.

     When this returns true, the caller should stop handling
     the provided action.
     */
    open func tryHandleReplacementAction(before gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        guard let action = replacementAction(for: gesture, on: action) else { return false }
        handle(.release, on: action, replaced: true)
        return true
    }

    /**
     Try to reinsert an automatically removed space that was
     removed due to autocomplete after the provided `gesture`
     has been performed on the provided `action`.
     */
    open func tryReinsertAutocompleteRemovedSpace(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .release else { return }
        guard action.shouldReinsertAutocompleteInsertedSpace else { return }
        textDocumentProxy.tryReinsertAutocompleteRemovedSpace()
    }

    /**
     Try to removed an autocomplete inserted space after the
     `gesture` has been performed on the provided `action`.
     */
    open func tryRemoveAutocompleteInsertedSpace(before gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .release else { return }
        guard action.shouldRemoveAutocompleteInsertedSpace else { return }
        textDocumentProxy.tryRemoveAutocompleteInsertedSpace()
    }
}

private extension StandardKeyboardActionHandler {

    func isSpaceCursorDrag(_ action: KeyboardAction) -> Bool {
        guard action == .space else { return false }
        guard let handler = spaceDragGestureHandler as? SpaceCursorDragGestureHandler else { return false }
        return handler.currentDragTextPositionOffset != 0
    }

    func tryHandleSpaceDrag(
        on action: KeyboardAction,
        from startLocation: CGPoint,
        to currentLocation: CGPoint
    ) {
        guard action == .space else { return }
        guard keyboardContext.spaceLongPressBehavior == .moveInputCursor else { return }
        guard isSpaceDragGestureActive else { return }
        let activationLocation = spaceDragActivationLocation ?? currentLocation
        spaceDragActivationLocation = activationLocation
        spaceDragGestureHandler.handleDragGesture(
            from: activationLocation,
            to: currentLocation
        )
    }

    func tryUpdateSpaceDragState(
        for gesture: KeyboardGesture,
        on action: KeyboardAction
    ) {
        guard action == .space else { return }
        switch gesture {
        case .press:
            isSpaceDragGestureActive = false
            spaceDragActivationLocation = nil
        case .longPress:
            isSpaceDragGestureActive = true
        default: return
        }
    }
}
#endif
