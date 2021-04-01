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
 and functions to customize the standard behavior.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public convenience init(
        inputViewController ivc: KeyboardInputViewController,
        spaceDragGestureHandler: DragGestureHandler? = nil,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        weak var input = ivc
        self.init(
            keyboardContext: ivc.keyboardContext,
            keyboardBehavior: ivc.keyboardBehavior,
            keyboardFeedbackHandler: ivc.keyboardFeedbackHandler,
            autocompleteContext: ivc.autocompleteContext,
            autocompleteAction: { input?.performAutocomplete() },
            changeKeyboardTypeAction: { input?.keyboardContext.keyboardType = $0 },
            spaceDragGestureHandler: spaceDragGestureHandler,
            spaceDragSensitivity: spaceDragSensitivity)
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
            context: keyboardContext, feedbackHandler: keyboardFeedbackHandler, sensitivity: spaceDragSensitivity)
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
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool {
        self.action(for: gesture, on: action) != nil
    }
    
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        handle(gesture, on: action, replaced: false)
    }
    
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
    
    
    // MARK: - Actions
    
    /**
     This is the standard action that is used by the handler
     when a gesture is performed on a certain action.
     */
    open func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch gesture {
        case .doubleTap: return action.standardDoubleTapAction
        case .longPress: return action.standardLongPressAction
        case .press: return action.standardPressAction
        case .release: return action.standardReleaseAction
        case .repeatPress: return action.standardRepeatAction
        case .tap: return action.standardTapAction
        }
    }
    
    
    // MARK: - Feedback
    
    /**
     Trigger feedback for a certain `gesture` on an `action`.
     
     By default this just calls the `keyboardFeedbackHandler`
     to let it handle the feedback, but you can override the
     function to easily customize gesture feedback.
     */
    open func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        keyboardFeedbackHandler.triggerFeedback(for: gesture, on: action, actionProvider: self.action)
    }
    
    
    // MARK: - Action Handling
    
    open func tryApplyAutocompleteSuggestion(before gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        guard action.shouldApplyAutocompleteSuggestion else { return }
        guard let suggestion = (autocompleteContext.suggestions.first { $0.isAutocomplete }) else { return }
        textDocumentProxy.insertAutocompleteSuggestion(suggestion, tryInsertSpace: false)
    }
    
    open func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldSwitchToPreferredKeyboardType(after: gesture, on: action) else { return }
        let newType = keyboardBehavior.preferredKeyboardType(after: gesture, on: action)
        changeKeyboardTypeAction(newType)
    }
    
    open func tryHandleReplacementAction(before gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        let locale = keyboardContext.locale
        guard
            gesture == .tap,
            case let .character(char) = action,
            let replacement = textDocumentProxy.preferredReplacement(for: char, locale: locale)
            else { return false }
        let newAction = KeyboardAction.character(replacement)
        handle(.tap, on: newAction, replaced: true)
        return true
    }
    
    open func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard keyboardBehavior.shouldEndSentence(after: gesture, on: action) else { return }
        textDocumentProxy.endSentence()
    }
    
    open func tryRegisterEmoji(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        switch action {
        case .emoji(let emoji): return EmojiCategory.frequentEmojiProvider.registerEmoji(emoji)
        default: return
        }
    }
    
    open func tryReinsertAutocompleteRemovedSpace(after gesture: KeyboardGesture, on action: KeyboardAction) {
        guard gesture == .tap else { return }
        guard action.shouldReinsertAutocompleteInsertedSpace else { return }
        textDocumentProxy.tryReinsertAutocompleteRemovedSpace()
    }
    
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
            settings: KeyboardFeedbackSettings(audioConfiguration: audioConfiguration, hapticConfiguration: hapticConfiguration))
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
            settings: KeyboardFeedbackSettings(audioConfiguration: audioConfiguration, hapticConfiguration: hapticConfiguration))
        self.keyboardFeedbackHandler = feedbackHandler
        self.spaceDragGestureHandler = SpaceCursorDragGestureHandler(
            context: inputViewController.keyboardContext,
            feedbackHandler: feedbackHandler,
            sensitivity: spaceDragSensitivity)
    }
    
    @available(*, deprecated, message: "Use the new function without sender instead.")
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        handle(gesture, on: action)
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
