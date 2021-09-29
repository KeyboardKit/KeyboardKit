//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This standard keyboard action handler is used by default by
 KeyboardKit and provides a standard way of handling actions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard action behavior.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        inputViewController ivc: KeyboardInputViewController,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        weak var input = ivc
        self.autocompleteAction = { input?.performAutocomplete() }
        self.autocompleteContext = ivc.autocompleteContext
        self.changeKeyboardTypeAction = { input?.keyboardContext.keyboardType = $0 }
        self.keyboardBehavior = ivc.keyboardBehavior
        self.keyboardContext = ivc.keyboardContext
        self.keyboardFeedbackHandler = ivc.keyboardFeedbackHandler
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? SpaceCursorDragGestureHandler(
            context: ivc.keyboardContext,
            feedbackHandler: ivc.keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity)
    }
    
    public init(
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        keyboardFeedbackHandler: KeyboardFeedbackHandler,
        autocompleteContext: AutocompleteContext,
        autocompleteAction: @escaping () -> Void,
        changeKeyboardTypeAction: @escaping (KeyboardType) -> Void,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        self.autocompleteAction = autocompleteAction
        self.autocompleteContext = autocompleteContext
        self.changeKeyboardTypeAction = changeKeyboardTypeAction
        self.keyboardBehavior = keyboardBehavior
        self.keyboardContext = keyboardContext
        self.keyboardFeedbackHandler = keyboardFeedbackHandler
        self.spaceDragGestureHandler = spaceDragGestureHandler ?? SpaceCursorDragGestureHandler(
            context: keyboardContext,
            feedbackHandler: keyboardFeedbackHandler,
            sensitivity: spaceDragSensitivity)
    }
    
    
    // MARK: - Dependencies
    
    public let autocompleteContext: AutocompleteContext
    public let keyboardBehavior: KeyboardBehavior
    public let keyboardContext: KeyboardContext
    public let keyboardFeedbackHandler: KeyboardFeedbackHandler
    public let spaceDragGestureHandler: DragGestureHandler
    
    public let autocompleteAction: () -> Void
    public let changeKeyboardTypeAction: (KeyboardType) -> Void
    
    
    // MARK: - Properties
    
    public var textDocumentProxy: UITextDocumentProxy { keyboardContext.textDocumentProxy }
    
    private var keyboardInputViewController: KeyboardInputViewController { .shared }
    
    
    // MARK: - Types
    
    public typealias GestureAction = KeyboardAction.GestureAction
    
    
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
     Try to handling a certain `gesture` n a certain `action`.
     
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
        gestureAction(keyboardInputViewController)
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
     are handled by. By default, the `standardAction` of the
     `action` is triggered.
     */
    open func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        action.standardAction(for: gesture)
    }
    
    /**
     Try to resolve a replacement keyboard action before the
     `gesture` is performed on the `action`.
     
     This should happen when, for instance, a quotation char
     is tapped, and it should be replaced with an ending one.
     
     You can override this function to customize how actions
     are replaced. By default, the `preferredReplacement` of
     the `textDocumentProxy` will be used.
     */
    open func replacementAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        guard
            gesture == .tap,
            case let .character(char) = action,
            let replacement = textDocumentProxy.preferredReplacement(for: char, locale: keyboardContext.locale)
            else { return nil }
        return .character(replacement)
    }
    
    /**
     Trigger feedback for a certain `gesture` on an `action`.
     
     You can override the function to customize how feedback
     is triggered. By default, the `keyboardFeedbackHandler`
     will be used.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        keyboardFeedbackHandler.triggerFeedback(
            for: gesture,
            on: action,
            actionProvider: self.action)
    }
    
    /**
     Try to apply an `isAutocomplete` autocomplete suggesion
     before the `gesture` has been performed on the `action`.
     */
    open func tryApplyAutocompleteSuggestion(before gesture: KeyboardGesture, on action: KeyboardAction) {
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
     before the `gesture` is performed on the `action`. When
     this returns `true`, the caller should abort.
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
    
    
    // MARK: - Deprecated (non-open deprecated in _Deprecated folder)
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler-based initializer")
    public init(
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        autocompleteAction: @escaping () -> Void,
        changeKeyboardTypeAction: @escaping (KeyboardType) -> Void,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        self.autocompleteAction = autocompleteAction
        self.autocompleteContext = autocompleteContext
        self.changeKeyboardTypeAction = changeKeyboardTypeAction
        self.keyboardBehavior = keyboardBehavior
        self.keyboardContext = keyboardContext
        let feedbackHandler = StandardKeyboardFeedbackHandler(
            settings: KeyboardFeedbackSettings(
                audioConfiguration: audioConfiguration,
                hapticConfiguration: hapticConfiguration))
        self.keyboardFeedbackHandler = feedbackHandler
        self.spaceDragGestureHandler = SpaceCursorDragGestureHandler(
            context: keyboardContext,
            feedbackHandler: feedbackHandler,
            sensitivity: spaceDragSensitivity)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler-based initializer")
    public init(
        inputViewController: KeyboardInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity) {
        weak var input = inputViewController
        self.autocompleteAction = { input?.performAutocomplete() }
        self.autocompleteContext = inputViewController.autocompleteContext
        self.changeKeyboardTypeAction = { input?.keyboardContext.keyboardType = $0 }
        self.keyboardContext = inputViewController.keyboardContext
        self.keyboardBehavior = inputViewController.keyboardBehavior
        let feedbackHandler = StandardKeyboardFeedbackHandler(
            settings: KeyboardFeedbackSettings(
                audioConfiguration: audioConfiguration,
                hapticConfiguration: hapticConfiguration))
        self.keyboardFeedbackHandler = feedbackHandler
        self.spaceDragGestureHandler = SpaceCursorDragGestureHandler(
            context: inputViewController.keyboardContext,
            feedbackHandler: feedbackHandler,
            sensitivity: spaceDragSensitivity)
    }
    
    @available(*, deprecated, message: "Use the new spaceDragGestureHandler instead.")
    open func handleSpaceCursorDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        spaceDragGestureHandler.handleDragGesture(from: startLocation, to: currentLocation)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler instead.")
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        keyboardFeedbackHandler.triggerAudioFeedback(for: gesture, on: action)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler instead.")
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        keyboardFeedbackHandler.triggerAudioFeedback(for: gesture, on: action)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler instead.")
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        keyboardFeedbackHandler.triggerHapticFeedback(for: gesture, on: action)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler instead.")
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        triggerHapticFeedback(for: gesture, on: action)
    }
    
    @available(*, deprecated, message: "Use the new keyboardFeedbackHandler instead.")
    open func triggerHapticFeedbackForLongPressOnSpaceDragGesture() {
        keyboardFeedbackHandler.triggerFeedbackForLongPressOnSpaceDragGesture()
    }
}
