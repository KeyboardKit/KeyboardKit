//
//  KeyboardAction+StandardHandlerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import XCTest

final class KeyboardAction_StandardHandlerTests: XCTestCase {
    
    typealias Gesture = Keyboard.Gesture

    private var handler: TestClass!
    var controller: MockKeyboardInputViewController!
    var spaceDragHandler: MockSpaceDragGestureHandler!
    var textDocumentProxy: MockTextDocumentProxy!
    
    var registeredEmojis: [Emoji] = []
    

    override func setUp() {
        registeredEmojis = []
        
        controller = MockKeyboardInputViewController()
        spaceDragHandler = MockSpaceDragGestureHandler(action: { _ in })
        textDocumentProxy = MockTextDocumentProxy()
        textDocumentProxy.documentContextBeforeInput = ""

        let state = controller.state
        let services = controller.services

        state.feedbackContext.settings.isAudioFeedbackEnabled = false
        state.feedbackContext.settings.isHapticFeedbackEnabled = false
        state.keyboardContext.locale = .swedish
        state.keyboardContext.originalTextDocumentProxy = textDocumentProxy
        services.spaceDragGestureHandler = spaceDragHandler
        
        handler = TestClass(controller: controller)
    }


    // MARK: - KeyboardActionHandler

    func testCanHandleGestureOnActionThatIsNotNil() {
        XCTAssertTrue(handler.canHandle(.press, on: .backspace))
        XCTAssertFalse(handler.canHandle(.doubleTap, on: .backspace))
    }
    
    func testHandlingGestureOnActionTriggersManyOperations() {
        handler.handle(.release, on: .character("a"))
        XCTAssertTrue(handler.hasCalled(\.tryRemoveAutocompleteInsertedSpaceRef))
        XCTAssertTrue(handler.hasCalled(\.tryApplyAutocorrectSuggestionRef))
        XCTAssertTrue(handler.hasCalled(\.tryReinsertAutocompleteRemovedSpaceRef))
        XCTAssertTrue(handler.hasCalled(\.tryEndCurrentSentenceRef))
        XCTAssertTrue(handler.hasCalled(\.tryChangeKeyboardTypeRef))
        XCTAssertTrue(controller.hasCalled(\.performAutocompleteRef))
        XCTAssertEqual(registeredEmojis, [])
    }
    
    func testHandlingGestureOnEmojiTriggersEmojiRegistration() {
        handler.handle(.release, on: .emoji(.init("👍")))
        handler.handle(.release, on: .emoji(.init("🤩")))
        XCTAssertTrue(handler.hasCalled(\.tryRemoveAutocompleteInsertedSpaceRef))
        XCTAssertTrue(handler.hasCalled(\.tryApplyAutocorrectSuggestionRef))
        XCTAssertTrue(handler.hasCalled(\.tryReinsertAutocompleteRemovedSpaceRef))
        XCTAssertTrue(handler.hasCalled(\.tryEndCurrentSentenceRef))
        XCTAssertTrue(handler.hasCalled(\.tryChangeKeyboardTypeRef))
        XCTAssertTrue(controller.hasCalled(\.performAutocompleteRef))
        // XCTAssertEqual(registeredEmojis.map { $0.char }, ["👍", "🤩"]) TODO: Use a mock!
    }
    

    func testHandlingDragGestureOnActionDoesNotDoAnythingOnNonSpaceActions() {
        let actions = KeyboardAction.testActions.filter { $0 != .space }
        actions.forEach {
            handler.handleDrag(on: $0, from: .zero, to: .zero)
        }
        XCTAssertFalse(spaceDragHandler.hasCalled(\.handleDragGestureRef))
    }


    // MARK: - Core Keyboard Logic

    func testShouldChangeKeyboardTypeUsesShouldBeTested() {
        // TODO
    }

    func testShouldEndCurrentSentenceUsesShouldBeTested() {
        // TODO
    }

    func testShouldRegisterEmojiReturnsTrueForReleaseOnEmoji() {
        XCTAssertFalse(handler.shouldRegisterEmoji(after: .press, on: .emoji("")))
        XCTAssertFalse(handler.shouldRegisterEmoji(after: .release, on: .space))
        XCTAssertTrue(handler.shouldRegisterEmoji(after: .release, on: .emoji("")))
    }

    func testTryChangeKeyboardTypeAfterGestureActionShouldBeTested() {
        // TODO
    }

    func testTryEndCurrentSentenceAfterGestureActionShouldBeTested() {
        // TODO
    }

    func testTryRegisterEmojiAfterGestureActionShouldBeTested() {
        // TODO
    }


    // MARK: - Actions

    func testActionForGestureOnActionIsNotDefinedForAllActionsWithStandardAction() {
        KeyboardAction.testActions.forEach { action in
            Gesture.allCases.forEach { gesture in
                let result = handler.action(for: gesture, on: action)
                let resultIsNil = result == nil
                let standardActionIsNil = action.standardAction(for: gesture) == nil
                XCTAssertEqual(resultIsNil, standardActionIsNil)
            }
        }
    }

    func testReplacementActionIsOnlyDefinedForReleaseOnCharWithProxyReplacement() {
        let context = controller.state.keyboardContext
        var result = handler.replacementAction(for: .press, on: .character("”"))
        XCTAssertNil(result)
        result = handler.replacementAction(for: .release, on: .backspace)
        XCTAssertNil(result)
        result = handler.replacementAction(for: .release, on: .character("A"))
        XCTAssertNil(result)
        context.locale = .swedish
        result = handler.replacementAction(for: .release, on: .character("‘"))
        XCTAssertNotNil(result)
        context.locale = .english
        result = handler.replacementAction(for: .release, on: .character("‘"))
        XCTAssertNil(result)
    }

    func testTryHandleReplacementActionTriggersWhenItShould() {
        let context = controller.state.keyboardContext
        var result = handler.tryHandleReplacementAction(before: .release, on: .character("A"))
        XCTAssertFalse(result)
        result = handler.tryHandleReplacementAction(before: .doubleTap, on: .character("A"))
        XCTAssertFalse(result)
        context.locale = .swedish
        result = handler.tryHandleReplacementAction(before: .release, on: .character("‘"))
        XCTAssertTrue(result)
        context.locale = .english
        result = handler.tryHandleReplacementAction(before: .release, on: .character("‘"))
        XCTAssertFalse(result)
    }


    // MARK: - Autocomplete

    func testShouldApplyAutocorrectSuggestionReturnsTrueForReleaseOnValidActionWithValidGestureContext() {
        spaceDragHandler.currentDragTextPositionOffset = 100
        XCTAssertFalse(handler.shouldApplyAutocorrectSuggestion(before: .release, on: .space)) // Invalid drag gesture
        spaceDragHandler.currentDragTextPositionOffset = 0
        textDocumentProxy.documentContextBeforeInput = "abc."
        XCTAssertFalse(handler.shouldApplyAutocorrectSuggestion(before: .release, on: .space)) // Completed word
        textDocumentProxy.documentContextBeforeInput = "abc"
        XCTAssertFalse(handler.shouldApplyAutocorrectSuggestion(before: .press, on: .space)) // Invalid gesture
        XCTAssertFalse(handler.shouldApplyAutocorrectSuggestion(before: .press, on: .backspace)) // Invalid action
        XCTAssertTrue(handler.shouldApplyAutocorrectSuggestion(before: .release, on: .space)) // Valid
        XCTAssertTrue(handler.shouldApplyAutocorrectSuggestion(before: .release, on: .character("."))) // Valid
    }

    func testShouldAutolearnSuggestionReturnsTrueForUnknownSuggestionWhenAutolearnIsEnabled() {
        let settings = handler.autocompleteContext.settings
        settings.isAutolearnEnabled = true
        XCTAssertFalse(handler.shouldAutolearnSuggestion(.init(text: "text", type: .regular))) // Invalid type
        XCTAssertFalse(handler.shouldAutolearnSuggestion(.init(text: "", type: .autocorrect))) // Empty text
        settings.isAutolearnEnabled = false
        XCTAssertFalse(handler.shouldAutolearnSuggestion(.init(text: "text", type: .autocorrect))) // Disabled
        settings.isAutolearnEnabled = true
        XCTAssertFalse(handler.shouldAutolearnSuggestion(.init(text: "text", type: .autocorrect))) // Valid
    }

    func testShouldAutocompleteIgnoreCurrentWordReturnsTrueWhenPressingBackspaceWithExistingWordAndAutocorrection() {
        textDocumentProxy.documentContextBeforeInput = "abc"
        handler.autocompleteContext.suggestions = [.init(text: "", type: .autocorrect)]
        XCTAssertFalse(handler.shouldAutoIgnoreCurrentWord(before: .release, on: .backspace)) // Invalid gesture
        XCTAssertFalse(handler.shouldAutoIgnoreCurrentWord(before: .press, on: .space)) // Invalid action
        textDocumentProxy.documentContextBeforeInput = ""
        XCTAssertFalse(handler.shouldAutoIgnoreCurrentWord(before: .press, on: .backspace)) // Missing word
        textDocumentProxy.documentContextBeforeInput = "abc"
        handler.autocompleteContext.suggestions = [.init(text: "", type: .unknown)]
        XCTAssertFalse(handler.shouldAutoIgnoreCurrentWord(before: .press, on: .backspace)) // Missing autocorrection
        handler.autocompleteContext.suggestions = [.init(text: "", type: .autocorrect)]
        XCTAssertTrue(handler.shouldAutoIgnoreCurrentWord(before: .press, on: .backspace)) // Valid
    }

    func testShouldPerformAutocompleteReturnsTrueForReleaseGesture() {
        XCTAssertFalse(handler.shouldPerformAutocomplete(after: .press, on: .backspace))
        XCTAssertTrue(handler.shouldPerformAutocomplete(after: .release, on: .backspace))
        XCTAssertTrue(handler.shouldPerformAutocomplete(after: .release, on: .space))
    }

    func testShouldReinsertAutocompleteRemovedSpaceReturnsTrueForReleaseOnValidAction() {
        XCTAssertFalse(handler.shouldReinsertAutocompleteRemovedSpace(after: .press, on: .character(".")))
        XCTAssertTrue(handler.shouldReinsertAutocompleteRemovedSpace(after: .release, on: .character(".")))
        XCTAssertFalse(handler.shouldReinsertAutocompleteRemovedSpace(after: .release, on: .space))
    }

    func testShouldRemoveAutocompleteInsertedSpaceReturnsTrueForReleaseOnValidAction() {
        XCTAssertFalse(handler.shouldRemoveAutocompleteInsertedSpace(before: .press, on: .character(".")))
        XCTAssertTrue(handler.shouldRemoveAutocompleteInsertedSpace(before: .release, on: .character(".")))
        XCTAssertFalse(handler.shouldRemoveAutocompleteInsertedSpace(before: .release, on: .space))
    }

    func testTryApplyCorrectSuggestionTriggersWhenItShould() {
        let ref = textDocumentProxy.deleteBackwardRef
        textDocumentProxy.documentContextBeforeInput = "abc"
        handler.autocompleteContext.suggestions = [.init(text: "", type: .autocorrect)]
        handler.tryApplyAutocorrectSuggestion(before: .press, on: .space) // Must be release
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))
        handler.tryApplyAutocorrectSuggestion(before: .release, on: .backspace) // Must be valid action
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))
        handler.autocompleteContext.suggestions = []
        handler.tryApplyAutocorrectSuggestion(before: .release, on: .space) // Must have actions
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))
        handler.autocompleteContext.suggestions = [.init(text: "", type: .autocorrect)]
        handler.tryApplyAutocorrectSuggestion(before: .release, on: .space) // Valid
        XCTAssertTrue(textDocumentProxy.hasCalled(ref))
    }

    func testTryAutocompleteIgnoreCurrentWordTriggersWhenItShould() {
        // TODO
    }

    func testTryAutolearnSuggestionTriggersWhenItShould() {
        // TODO
    }

    func testTryToReinsertAutocompleteRemovedSpaceTriggersWhenItShould() {
        textDocumentProxy.documentContextBeforeInput = "hi"
        textDocumentProxy.documentContextAfterInput = "you"
        textDocumentProxy.tryInsertSpaceAfterAutocomplete()
        textDocumentProxy.documentContextBeforeInput = "hi "
        textDocumentProxy.tryRemoveAutocompleteInsertedSpace()
        textDocumentProxy.resetCalls()

        handler.tryReinsertAutocompleteRemovedSpace(after: .press, on: .character(","))
        XCTAssertFalse(textDocumentProxy.hasCalled(\.insertTextRef))
        handler.tryReinsertAutocompleteRemovedSpace(after: .release, on: .character("A"))
        XCTAssertFalse(textDocumentProxy.hasCalled(\.insertTextRef))
        handler.tryReinsertAutocompleteRemovedSpace(after: .release, on: .character(","))
        XCTAssertTrue(textDocumentProxy.hasCalled(\.insertTextRef))

        textDocumentProxy.resetCalls()
    }


    // MARK: - Feedback

    func audioResult(for gesture: Keyboard.Gesture, on action: KeyboardAction) -> Bool {
        handler.shouldTriggerAudioFeedback(for: gesture, on: action)
    }

    func hapticResult(for gesture: Keyboard.Gesture, on action: KeyboardAction) -> Bool {
        handler.shouldTriggerHapticFeedback(for: gesture, on: action)
    }

    func testAudioFeedbackShouldOnlyTriggerIfSettingsIsEnabled() {
        controller.state.feedbackContext.settings.isAudioFeedbackEnabled = false
        XCTAssertFalse(audioResult(for: .press, on: .character("a")))
        controller.state.feedbackContext.settings.isAudioFeedbackEnabled = true
        XCTAssertTrue(audioResult(for: .press, on: .character("a")))
    }

    func testHapticFeedbackShouldAlwaysTriggerForLongPressOnSpace() {
        controller.state.feedbackContext.settings.isHapticFeedbackEnabled = false
        XCTAssertTrue(hapticResult(for: .longPress, on: .space))
        controller.state.feedbackContext.settings.isHapticFeedbackEnabled = true
        XCTAssertTrue(hapticResult(for: .longPress, on: .space))
    }

    func testHapticFeedbackShouldOnlyTriggerForSomeActionGesturesIfSettingsIsEnabled() {
        controller.state.feedbackContext.settings.isHapticFeedbackEnabled = false
        XCTAssertFalse(hapticResult(for: .press, on: .character("a")))
        XCTAssertFalse(hapticResult(for: .release, on: .character("a")))
        controller.state.feedbackContext.settings.isHapticFeedbackEnabled = true
        XCTAssertTrue(hapticResult(for: .press, on: .character("a")))
        XCTAssertFalse(hapticResult(for: .release, on: .character("a")))
    }

    func testTriggerFeedbackForGestureOnActionCallsInjectedHandler() {
        // TODO: Implement a mock feedback handler and inspect the result
        // handler.triggerFeedback(for: .press, on: .character(""))
        // let audioCalls = audioEngine.calls(to: \.triggerRef)
        // let hapticCalls = hapticEngine.calls(to: \.triggerRef)
        // XCTAssertEqual(audioCalls.count, 1)
        // XCTAssertEqual(hapticCalls.count, 1)
    }
    
    func validateAudioFeedback(
        for gesture: Gesture,
        on action: KeyboardAction,
        expected: Feedback.Audio?
    ) {
        let result = handler.audioFeedback(for: gesture, on: action)
        XCTAssertEqual(result, expected)
    }
    
    func testAudioFeedbackForGestureOnActionReturnsCorrectValue() {
        let config = handler.feedbackContext.audioConfiguration
        validateAudioFeedback(for: .longPress, on: .space, expected: nil)
        validateAudioFeedback(for: .press, on: .backspace, expected: config.delete)
        validateAudioFeedback(for: .press, on: .character("a"), expected: config.input)
        validateAudioFeedback(for: .press, on: .shift(.auto), expected: config.system)
    }
    
    func validateHapticFeedback(
        for gesture: Gesture,
        on action: KeyboardAction,
        expected: Feedback.Haptic?
    ) {
        let result = handler.hapticFeedback(for: gesture, on: action)
        XCTAssertEqual(result, expected)
    }
    
    func testHapticFeedbackForGestureOnActionReturnsCorrectValue() {
        let config = handler.feedbackContext.hapticConfiguration
        let char = KeyboardAction.character("a")
        validateHapticFeedback(for: .doubleTap, on: char, expected: config.doubleTap)
        validateHapticFeedback(for: .longPress, on: char, expected: config.longPress)
        validateHapticFeedback(for: .press, on: char, expected: config.press)
        validateHapticFeedback(for: .release, on: char, expected: config.release)
        validateHapticFeedback(for: .repeatPress, on: char, expected: config.repeat)
        
    }
}

private class TestClass: KeyboardAction.StandardHandler, Mockable {

    var mock = Mock()

    lazy var handleGestureOnActionRef = MockReference(handle as (Keyboard.Gesture, KeyboardAction) -> Void)
    lazy var tryApplyAutocorrectSuggestionRef = MockReference(tryApplyAutocorrectSuggestion)
    lazy var tryChangeKeyboardTypeRef = MockReference(tryChangeKeyboardType)
    lazy var tryEndCurrentSentenceRef = MockReference(tryEndCurrentSentence)
    lazy var tryReinsertAutocompleteRemovedSpaceRef = MockReference(tryReinsertAutocompleteRemovedSpace)
    lazy var tryRemoveAutocompleteInsertedSpaceRef = MockReference(tryRemoveAutocompleteInsertedSpace)

    override func handle(_ gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.handle(gesture, on: action)
        call(handleGestureOnActionRef, args: (gesture, action))
    }

    override func tryApplyAutocorrectSuggestion(before gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.tryApplyAutocorrectSuggestion(before: gesture, on: action)
        call(tryApplyAutocorrectSuggestionRef, args: (gesture, action))
    }
    
    override func tryChangeKeyboardType(after gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.tryChangeKeyboardType(after: gesture, on: action)
        call(tryChangeKeyboardTypeRef, args: (gesture, action))
    }

    override func tryEndCurrentSentence(after gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.tryEndCurrentSentence(after: gesture, on: action)
        call(tryEndCurrentSentenceRef, args: (gesture, action))
    }

    override func tryReinsertAutocompleteRemovedSpace(after gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
        call(tryReinsertAutocompleteRemovedSpaceRef, args: (gesture, action))
    }

    override func tryRemoveAutocompleteInsertedSpace(before gesture: Keyboard.Gesture, on action: KeyboardAction) {
        super.tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
        call(tryRemoveAutocompleteInsertedSpaceRef, args: (gesture, action))
    }
}
#endif
