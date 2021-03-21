//
//  StandardKeyboardActionHandler.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This action handler provides standard ways of how to handle
 keyboard actions.
 
 You can inherit this class and override any open properties
 and functions to customize the standard behavior.
 
 You can provide a custom `haptic` and `audio` configuration
 when you create an instance of this class. The standard aim
 at mimicing the behavior of a native keyboard. You can also
 provide a custom `spaceDragSensitivity`.
 
 `TODO` Many features in this class were hard to test and as
 such, many tests are missing. I think that the more complex
 pieces of logic could be extracted to protocols in separate
 files to simplify testing and changing the behavior of this
 class without having to subclass.
 */
open class StandardKeyboardActionHandler: NSObject, KeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(
        keyboardContext: KeyboardContext,
        keyboardBehavior: KeyboardBehavior,
        autocompleteContext: AutocompleteContext,
        autocompleteAction: @escaping () -> Void,
        changeKeyboardTypeAction: @escaping (KeyboardType) -> Void,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        self.keyboardContext = keyboardContext
        self.keyboardBehavior = keyboardBehavior
        self.autocompleteContext = autocompleteContext
        self.autocompleteAction = autocompleteAction
        self.changeKeyboardTypeAction = changeKeyboardTypeAction
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
        self.spaceDragSensitivity = spaceDragSensitivity
    }
    
    public init(
        inputViewController: KeyboardInputViewController,
        hapticConfiguration: HapticFeedbackConfiguration = .standard,
        audioConfiguration: AudioFeedbackConfiguration = .standard,
        spaceDragSensitivity: SpaceDragSensitivity = .medium) {
        weak var input = inputViewController
        self.keyboardContext = inputViewController.keyboardContext
        self.keyboardBehavior = inputViewController.keyboardBehavior
        self.autocompleteContext = inputViewController.autocompleteContext
        self.autocompleteAction = { input?.performAutocomplete() }
        self.changeKeyboardTypeAction = { input?.keyboardContext.keyboardType = $0 }
        self.hapticConfiguration = hapticConfiguration
        self.audioConfiguration = audioConfiguration
        self.spaceDragSensitivity = spaceDragSensitivity
    }
    
    
    // MARK: - Dependencies
    
    public let audioConfiguration: AudioFeedbackConfiguration
    public let autocompleteContext: AutocompleteContext
    public let keyboardBehavior: KeyboardBehavior
    public let keyboardContext: KeyboardContext
    public let hapticConfiguration: HapticFeedbackConfiguration
    public let spaceDragSensitivity: SpaceDragSensitivity
    
    public let autocompleteAction: () -> Void
    public let changeKeyboardTypeAction: (KeyboardType) -> Void
    
    
    // MARK: - Properties
    
    public var textDocumentProxy: UITextDocumentProxy { keyboardContext.textDocumentProxy }
    
    private var currentDragStartLocation: CGPoint?
    private var currentDragTextPositionOffset: Int = 0
    private var keyboardInputViewController: KeyboardInputViewController { .shared }
    
    
    // MARK: - Types
    
    public typealias GestureAction = KeyboardAction.GestureAction
    
    
    // MARK: - KeyboardActionHandler
    
    public func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) -> Bool {
        self.action(for: gesture, on: action) != nil
    }
    
    /**
     Handle a certain `gesture` on a certain `action`
     */
    open func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        if tryHandleReplaceAction(for: gesture, on: action) { return }
        guard let gestureAction = self.action(for: gesture, on: action) else { return }
        tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
        tryApplyAutocompleteSuggestion(before: gesture, on: action)
        gestureAction(keyboardInputViewController)
        tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
        triggerAudioFeedback(for: gesture, on: action, sender: sender)
        triggerHapticFeedback(for: gesture, on: action, sender: sender)
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
        case .space: handleSpaceCursorDragGesture(from: startLocation, to: currentLocation)
        default: break
        }
    }
    
    /**
     This function is called from `handleDrag` and moves the
     text cursor according to the last handled offset.
     */
    open func handleSpaceCursorDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        tryStartNewSpaceCursorDragGesture(from: startLocation, to: currentLocation)
        let dragDelta = startLocation.x - currentLocation.x
        let textPositionOffset = Int(dragDelta / CGFloat(spaceDragSensitivity.points))
        guard textPositionOffset != currentDragTextPositionOffset else { return }
        let offsetDelta = textPositionOffset - currentDragTextPositionOffset
        textDocumentProxy.adjustTextPosition(byCharacterOffset: -offsetDelta)
        currentDragTextPositionOffset = textPositionOffset
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
    
    
    // MARK: - Action Handling
    
    open func replacementAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        if let action = replacementQuotationAction(for: gesture, on: action) { return action }
        if let action = replacementAlternateQuotationAction(for: gesture, on: action) { return action }
        return nil
    }
    
    open func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        if action == .backspace { return audioConfiguration.deleteFeedback.trigger() }
        if action.isInputAction { return audioConfiguration.inputFeedback.trigger() }
        if action.isSystemAction { return audioConfiguration.systemFeedback.trigger() }
    }
    
    open func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        switch gesture {
        case .doubleTap: hapticConfiguration.doubleTapFeedback.trigger()
        case .longPress: hapticConfiguration.longPressFeedback.trigger()
        case .press: hapticConfiguration.tapFeedback.trigger()
        case .release: hapticConfiguration.tapFeedback.trigger()
        case .repeatPress: hapticConfiguration.repeatFeedback.trigger()
        case .tap: hapticConfiguration.tapFeedback.trigger()
        }
    }
    
    open func triggerHapticFeedbackForLongPressOnSpaceDragGesture() {
        hapticConfiguration.longPressOnSpaceFeedback.trigger()
    }
    
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
    
    open func tryHandleReplaceAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        guard let action = replacementAction(for: gesture, on: action) else { return false }
        handle(gesture, on: action)
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
}


// MARK: - Private Functions

private extension StandardKeyboardActionHandler {

    func replacementAlternateQuotationAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        let locale = keyboardContext.locale
        guard gesture == .tap else { return nil }
        guard case let .character(char) = action else { return nil }
        guard let beginDelimiter = locale.alternateQuotationBeginDelimiter else { return nil }
        guard let endDelimiter = locale.alternateQuotationEndDelimiter else { return nil }
        guard beginDelimiter != endDelimiter else { return nil }
        guard char == endDelimiter || char == "’" else { return nil }
        guard !textDocumentProxy.isOpenAlternateQuotationBeforeInput(for: locale) else { return nil }
        return .character(beginDelimiter)
    }
    
    func replacementQuotationAction(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction? {
        let locale = keyboardContext.locale
        guard gesture == .tap else { return nil }
        guard case let .character(char) = action else { return nil }
        guard let beginDelimiter = locale.quotationBeginDelimiter else { return nil }
        guard let endDelimiter = locale.quotationEndDelimiter else { return nil }
        guard beginDelimiter != endDelimiter else { return nil }
        guard char == endDelimiter || char == "”" else { return nil }
        guard !textDocumentProxy.isOpenQuotationBeforeInput(for: locale) else { return nil }
        return .character(beginDelimiter)
    }
    
    func tryStartNewSpaceCursorDragGesture(from startLocation: CGPoint, to currentLocation: CGPoint) {
        let isNewDrag = currentDragStartLocation != startLocation
        currentDragStartLocation = startLocation
        guard isNewDrag else { return }
        currentDragTextPositionOffset = 0
        triggerHapticFeedbackForLongPressOnSpaceDragGesture()
    }
}
