//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This standard keyboard action handler is used by default by
 KeyboardKit and provides a standard way of handling actions.

 You can inherit this class and override any open properties
 and functions to customize the standard action behavior.

 Note that this action handler is only available on keyboard
 supporting platforms. For unsupported platforms, a disabled
 action handler will be used by default.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {


    // MARK: - Initialization

    /**
     Create a standard keyboard action handler, using a view
     controller to setup all dependencies.

     - Parameters:
       - inputViewController: The view controller to use.
       - spaceDragGestureHandler: A custom space drag gesture handler, if any.
       - spaceDragSensitivity: The space drag sensitivity to use, by default ``SpaceDragSensitivity/medium``.
       -
     */
    public init(
        inputViewController ivc: KeyboardInputViewController,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium
    ) {
        weak var input = ivc
        self.autocompleteAction = { input?.performAutocomplete() }
        self.autocompleteContext = ivc.autocompleteContext
        self.changeKeyboardTypeAction = { input?.keyboardContext.keyboardType = $0 }
        self.keyboardBehavior = ivc.keyboardBehavior
        self.keyboardContext = ivc.keyboardContext
        self.keyboardFeedbackHandler = ivc.keyboardFeedbackHandler
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? SpaceCursorDragGestureHandler(
            keyboardContext: ivc.keyboardContext,
            feedbackHandler: ivc.keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity
        )
    }

    /**
     Create a standard keyboard action handler.

     - Parameters:
       - keyboardContext: The keyboard context to use.
       - keyboardBehavior: The keyboard behavior to use.
       - keyboardFeedbackHandler: The keyboard feedback handler to use.
       - autocompleteContext: The autocomplete context to use.
       - autocompleteAction: The autocomplete action to use.
       - changeKeyboardTypeAction: The action to use to change keyboard type.
       - spaceDragGestureHandler: A custom space drag gesture handler, if any.
       - spaceDragSensitivity: The space drag sensitivity to use, by default ``SpaceDragSensitivity/medium``.
     */
    public init(
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        keyboardFeedbackHandler: KeyboardFeedbackHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteAction: @escaping () -> Void,
        changeKeyboardTypeAction: @escaping (KeyboardType) -> Void,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium
    ) {
        self.autocompleteAction = autocompleteAction
        self.autocompleteContext = autocompleteContext
        self.changeKeyboardTypeAction = changeKeyboardTypeAction
        self.keyboardBehavior = keyboardBehavior
        self.keyboardContext = keyboardContext
        self.keyboardFeedbackHandler = keyboardFeedbackHandler
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? SpaceCursorDragGestureHandler(
            keyboardContext: keyboardContext,
            feedbackHandler: keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity
        )
    }


    // MARK: - Dependencies

    public let autocompleteContext: AutocompleteContext
    public let keyboardBehavior: KeyboardBehavior
    public let keyboardContext: KeyboardContext
    public let keyboardFeedbackHandler: KeyboardFeedbackHandler
    public let spaceDragGestureHandler: DragGestureHandler

    public internal(set) var autocompleteAction: () -> Void

    /**
     The action to use to change keyboard type.

     > Deprecated: This action is no longer needed, and will
     be removed in KK 7.0. Just affect the proxy directly.
     */
    public let changeKeyboardTypeAction: (KeyboardType) -> Void


    // MARK: - Properties

    public var textDocumentProxy: UITextDocumentProxy { keyboardContext.textDocumentProxy }


    // MARK: - KeyboardActionHandler

    /**
     Whether or not the action handler can be used to handle
     a certain `gesture` on a certain `action`.
     */
    open func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        self.action(for: gesture, on: action) != nil
    }

    /**
     Try to handling a certain `gesture` n a certain `action`.
     */
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        handle(gesture, on: action, replaced: false)
    }

    /**
     Try handling a certain `gesture` on a certain `action`.

     This function is used by the standard action handler to
     handle the cases where the action can be triggered as a
     result of another operation, e.g. autocomplete handling.
     */
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, replaced: Bool) {
        if !replaced && tryHandleReplacementAction(before: gesture, on: action) { return }
        triggerFeedback(for: gesture, on: action)
        guard let gestureAction = self.action(for: gesture, on: action) else { return }
        tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
        tryApplyAutocompleteSuggestion(before: gesture, on: action)
        gestureAction(.shared)
        tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
        tryEndSentence(after: gesture, on: action)
        tryChangeKeyboardType(after: gesture, on: action)
        tryRegisterEmoji(after: gesture, on: action)
        autocompleteAction()
    }

    /**
     Handle a drag gesture on a certain action, from a start
     location to the drag gesture's current location.
     */
    open func handleDrag(on action: KeyboardAction, from startLocation: CGPoint, to currentLocation: CGPoint) {
        switch action {
        case .space: spaceDragGestureHandler.handleDragGesture(from: startLocation, to: currentLocation)
        default: break
        }
    }


    // MARK: - Open Functions

    /**
     This is the standard action that is used by the handler
     when a gesture is performed on a certain action.

     You can override this function to customize how actions
     should behave. By default, the standard action is used.
     */
    open func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        action.standardAction(for: gesture)
    }

    /**
     Try to resolve a replacement keyboard action before the
     `gesture` is performed on the provided `action`.

     You can override this function to customize how actions
     should be replaced.
     */
    open func replacementAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        guard gesture == .tap else { return nil }

        // Apply proxy-based replacements, if any
        if case let .character(char) = action,
           let replacement = textDocumentProxy.preferredReplacement(for: char, locale: keyboardContext.locale) {
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

     By default, the function will return `true` for a press
     on a gesture that has a tap action or if the gesture is
     not a tap and the action has an action for that gesture.

     You can override this function to customize how actions
     trigger feedback.
     */
    open func shouldTriggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        if gesture == .press && self.action(for: .tap, on: action) != nil { return true }
        if gesture != .tap && gesture != .release && self.action(for: gesture, on: action) != nil { return true }
        return false
    }

    /**
     Trigger feedback for a certain `gesture` on an `action`,
     if ``shouldTriggerFeedback(for:on:)`` returns `true`.

     You can override this function to customize how actions
     trigger feedback.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        guard shouldTriggerFeedback(for: gesture, on: action) else { return }
        keyboardFeedbackHandler.triggerFeedback(for: gesture, on: action)
    }

    /**
     Try to apply an `isAutocomplete` autocomplete suggesion
     before the `gesture` has been performed on the `action`.
     */
    open func tryApplyAutocompleteSuggestion(before gesture: KeyboardGesture, on action: KeyboardAction) {
        if isSpaceCursorDrag(action) { return }
        if textDocumentProxy.isCursorAtNewWord { return }
        guard gesture == .tap else { return }
        guard action.shouldApplyAutocompleteSuggestion else { return }
        guard let suggestion = (autocompleteContext.suggestions.first { $0.isAutocomplete }) else { return }
        textDocumentProxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
    }

    /**
     Try to change `keyboardType` after a `gesture` has been
     performed on the provided `action`.
     */
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action) else { return }
        let newType = keyboardBehavior.preferredKeyboardType(after: gesture, on: action)
        changeKeyboardTypeAction(newType)
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
        handle(.tap, on: action, replaced: true)
        return true
    }

    /**
     Try to register a certain emoji after the `gesture` has
     been performed on the provided `action`.
     */
    open func tryRegisterEmoji(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        switch action {
        case .emoji(let emoji): return EmojiCategory.frequentEmojiProvider.registerEmoji(emoji)
        default: return
        }
    }

    /**
     Try to reinsert an automatically removed space that was
     removed due to autocomplete after the provided `gesture`
     has been performed on the provided `action`.
     */
    open func tryReinsertAutocompleteRemovedSpace(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        guard action.shouldReinsertAutocompleteInsertedSpace else { return }
        textDocumentProxy.tryReinsertAutocompleteRemovedSpace()
    }

    /**
     Try to removed an autocomplete inserted space after the
     `gesture` has been performed on the provided `action`.
     */
    open func tryRemoveAutocompleteInsertedSpace(before gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
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
}
#endif
