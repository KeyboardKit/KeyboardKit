//
//  StandardKeyboardActionHandlerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import XCTest

@testable import KeyboardKit

final class StandardKeyboardActionHandlerTests: XCTestCase {

    private var handler: TestClass!
    var emojiProvider: MockFrequentEmojiProvider!
    var feedbackHandler: MockKeyboardFeedbackHandler!
    var spaceDragHandler: MockDragGestureHandler!
    var textDocumentProxy: MockTextDocumentProxy!

    var originalEmojiProvider: FrequentEmojiProvider!

    override func setUp() {
        let controller = MockKeyboardInputViewController()
        emojiProvider = MockFrequentEmojiProvider()
        feedbackHandler = MockKeyboardFeedbackHandler()
        spaceDragHandler = MockDragGestureHandler()
        textDocumentProxy = MockTextDocumentProxy()

        controller.keyboardContext.textDocumentProxy = textDocumentProxy
        originalEmojiProvider = EmojiCategory.frequentEmojiProvider
        EmojiCategory.frequentEmojiProvider = emojiProvider

        handler = TestClass(
            keyboardContext: controller.keyboardContext,
            keyboardBehavior: controller.keyboardBehavior,
            keyboardFeedbackHandler: feedbackHandler,
            autocompleteContext: controller.autocompleteContext,
            autocompleteAction: {},
            changeKeyboardTypeAction: { _ in },
            spaceDragGestureHandler: spaceDragHandler)
    }

    override func tearDown() {
        EmojiCategory.frequentEmojiProvider = originalEmojiProvider
    }


    func testCanHandleGestureOnActionThatIsNotNil() {
        XCTAssertTrue(handler.canHandle(.tap, on: .backspace))
        XCTAssertFalse(handler.canHandle(.doubleTap, on: .backspace))
    }

    func testHandlingGestureOnActionTriggersManyOperations() {
        handler.handle(.tap, on: .character("a"))
        XCTAssertTrue(handler.hasCalled(handler.tryRemoveAutocompleteInsertedSpaceRef))
        XCTAssertTrue(handler.hasCalled(handler.tryApplyAutocompleteSuggestionRef))
        XCTAssertTrue(handler.hasCalled(handler.tryReinsertAutocompleteRemovedSpaceRef))
        XCTAssertTrue(handler.hasCalled(handler.tryEndSentenceRef))
        XCTAssertTrue(handler.hasCalled(handler.tryChangeKeyboardTypeRef))
        XCTAssertTrue(handler.hasCalled(handler.tryRegisterEmojiRef))
        XCTAssertTrue(handler.hasCalled(handler.autocompleteActionRef))
    }

    func testHandlingDragGestureOnActionUsesSpaceDragHandlerForSpace() {
        handler.handleDrag(on: .space, from: .init(x: 1, y: 2), to: .init(x: 3, y: 4))
        let calls = spaceDragHandler.calls(to: spaceDragHandler.handleDragGestureRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments.0, CGPoint.init(x: 1, y: 2))
        XCTAssertEqual(calls[0].arguments.1, CGPoint.init(x: 3, y: 4))
    }

    func testHandlingDragGestureOnActionDoesNotDoAnythingOnNonSpaceActions() {
        let actions = KeyboardAction.testActions.filter { $0 != .space }
        actions.forEach {
            handler.handleDrag(on: $0, from: .zero, to: .zero)
        }
        XCTAssertFalse(spaceDragHandler.hasCalled(spaceDragHandler.handleDragGestureRef))
    }


    func testActionForGestureOnActionIsNotForAllActionsWithStandardAction() {
        KeyboardAction.testActions.forEach { action in
            KeyboardGesture.allCases.forEach { gesture in
                let result = handler.action(for: gesture, on: action)
                let resultIsNil = result == nil
                let standardActionIsNil = action.standardAction(for: gesture) == nil
                XCTAssertEqual(resultIsNil, standardActionIsNil)
            }
        }
    }

    func testReplacementActionIsOnlyDefinedForTapOnCharWithProxyReplacement() {
        var result = handler.replacementAction(for: .press, on: .character("”"))
        XCTAssertNil(result)
        result = handler.replacementAction(for: .tap, on: .backspace)
        XCTAssertNil(result)
        result = handler.replacementAction(for: .tap, on: .character("A"))
        XCTAssertNil(result)
        result = handler.replacementAction(for: .tap, on: .character("‘"))
        XCTAssertNotNil(result)
    }

    func testShouldTriggerFeedbackForGestureOnActionReturnsTrueInSomeCases() {
        var result = handler.shouldTriggerFeedback(for: .press, on: .control)
        XCTAssertFalse(result)
        result = handler.shouldTriggerFeedback(for: .press, on: .character(""))
        XCTAssertTrue(result)
        result = handler.shouldTriggerFeedback(for: .tap, on: .character(""))
        XCTAssertFalse(result)
        result = handler.shouldTriggerFeedback(for: .release, on: .character(""))
        XCTAssertFalse(result)
        result = handler.shouldTriggerFeedback(for: .longPress, on: .space)
        XCTAssertTrue(result)
    }

    func testTriggerFeedbackForGestureOnActionCallsInjectedHandler() {
        handler.triggerFeedback(for: .press, on: .character(""))
        let calls = feedbackHandler.calls(to: feedbackHandler.triggerFeedbackRef)
        XCTAssertEqual(calls.count, 1)
        XCTAssertEqual(calls[0].arguments.0, .press)
        XCTAssertEqual(calls[0].arguments.1, .character(""))
    }

    func testTryApplyAutocompleteSuggestionOnlyProceedsForTapOnSomeActionsWhenSuggestionsExist() {
        let ref = textDocumentProxy.adjustTextPositionRef
        let autocompleteSuggestions = [StandardAutocompleteSuggestion(text: "", isAutocomplete: true, isUnknown: false)]

        textDocumentProxy.documentContextBeforeInput = "abc"
        handler.autocompleteContext.suggestions = autocompleteSuggestions

        handler.tryApplyAutocompleteSuggestion(before: .press, on: .space)
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))

        handler.tryApplyAutocompleteSuggestion(before: .tap, on: .backspace)
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))

        handler.autocompleteContext.suggestions = []
        handler.tryApplyAutocompleteSuggestion(before: .tap, on: .space)
        XCTAssertFalse(textDocumentProxy.hasCalled(ref))

        handler.autocompleteContext.suggestions = autocompleteSuggestions
        handler.tryApplyAutocompleteSuggestion(before: .tap, on: .space)
        XCTAssertTrue(textDocumentProxy.hasCalled(ref))
    }

    func testTryingToEndSentenceAfterGestureOnActionIsOnlyCalledIfBehaviorSaysYes() {
        textDocumentProxy.documentContextBeforeInput = ""
        handler.tryEndSentence(after: .tap, on: .character("a"))
        XCTAssertFalse(textDocumentProxy.hasCalled(textDocumentProxy.deleteBackwardRef))
        XCTAssertFalse(textDocumentProxy.hasCalled(textDocumentProxy.insertTextRef))

        textDocumentProxy.documentContextBeforeInput = "foo  "
        handler.tryEndSentence(after: .tap, on: .space)
        XCTAssertTrue(textDocumentProxy.hasCalled(textDocumentProxy.deleteBackwardRef, numberOfTimes: 2))
        XCTAssertTrue(textDocumentProxy.hasCalled(textDocumentProxy.insertTextRef, numberOfTimes: 1))
    }

    func testTryToHandleReplacementActionBeforeGestureOnActionReturnsTrueForTapOnValidCharAction() {
        var result = handler.tryHandleReplacementAction(before: .tap, on: .character("A"))
        XCTAssertFalse(result)
        result = handler.tryHandleReplacementAction(before: .doubleTap, on: .character("A"))
        XCTAssertFalse(result)
        result = handler.tryHandleReplacementAction(before: .tap, on: .character("‘"))
        XCTAssertTrue(result)
    }

    func testTryToRegisterEmojiAfterGestureOnActionRegisterEmojiForTapsOnEmoji() {
        handler.tryRegisterEmoji(after: .doubleTap, on: .emoji(Emoji("a")))
        XCTAssertFalse(emojiProvider.hasCalled(emojiProvider.registerEmojiRef))
        handler.tryRegisterEmoji(after: .tap, on: .space)
        XCTAssertFalse(emojiProvider.hasCalled(emojiProvider.registerEmojiRef))
        handler.tryRegisterEmoji(after: .tap, on: .emoji(Emoji("a")))
        XCTAssertTrue(emojiProvider.hasCalled(emojiProvider.registerEmojiRef))
    }

    func testTryToReinsertAutocompleteRemovedSpaceAfterGestureOnActionProceedsForTapOnSomeActions() {
        textDocumentProxy.documentContextBeforeInput = "hi"
        textDocumentProxy.documentContextAfterInput = "you"
        textDocumentProxy.tryInsertSpaceAfterAutocomplete()
        textDocumentProxy.documentContextBeforeInput = "hi "
        textDocumentProxy.tryRemoveAutocompleteInsertedSpace()
        textDocumentProxy.resetCalls()

        handler.tryReinsertAutocompleteRemovedSpace(after: .press, on: .character(","))
        XCTAssertFalse(textDocumentProxy.hasCalled(textDocumentProxy.insertTextRef))
        handler.tryReinsertAutocompleteRemovedSpace(after: .tap, on: .character("A"))
        XCTAssertFalse(textDocumentProxy.hasCalled(textDocumentProxy.insertTextRef))
        handler.tryReinsertAutocompleteRemovedSpace(after: .tap, on: .character(","))
        XCTAssertTrue(textDocumentProxy.hasCalled(textDocumentProxy.insertTextRef))

        textDocumentProxy.resetCalls()
    }
}

private class TestClass: StandardKeyboardActionHandler, Mockable {

    var mock = Mock()

    lazy var autocompleteActionRef = MockReference(autocompleteAction)
    lazy var handleGestureOnActionRef = MockReference(handle as (KeyboardGesture, KeyboardAction) -> Void)
    lazy var tryApplyAutocompleteSuggestionRef = MockReference(tryApplyAutocompleteSuggestion)
    lazy var tryChangeKeyboardTypeRef = MockReference(tryChangeKeyboardType)
    lazy var tryEndSentenceRef = MockReference(tryEndSentence)
    lazy var tryRegisterEmojiRef = MockReference(tryRegisterEmoji)
    lazy var tryReinsertAutocompleteRemovedSpaceRef = MockReference(tryReinsertAutocompleteRemovedSpace)
    lazy var tryRemoveAutocompleteInsertedSpaceRef = MockReference(tryRemoveAutocompleteInsertedSpace)

    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        autocompleteAction = { self.call(self.autocompleteActionRef, args: ()) }
        super.handle(gesture, on: action)
        call(handleGestureOnActionRef, args: (gesture, action))
    }

    override func tryApplyAutocompleteSuggestion(before gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryApplyAutocompleteSuggestion(before: gesture, on: action)
        call(tryApplyAutocompleteSuggestionRef, args: (gesture, action))
    }
    
    override func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryChangeKeyboardType(after: gesture, on: action)
        call(tryChangeKeyboardTypeRef, args: (gesture, action))
    }

    override func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryEndSentence(after: gesture, on: action)
        call(tryEndSentenceRef, args: (gesture, action))
    }

    override func tryRegisterEmoji(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryRegisterEmoji(after: gesture, on: action)
        call(tryRegisterEmojiRef, args: (gesture, action))
    }

    override func tryReinsertAutocompleteRemovedSpace(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryReinsertAutocompleteRemovedSpace(after: gesture, on: action)
        call(tryReinsertAutocompleteRemovedSpaceRef, args: (gesture, action))
    }

    override func tryRemoveAutocompleteInsertedSpace(before gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryRemoveAutocompleteInsertedSpace(before: gesture, on: action)
        call(tryRemoveAutocompleteInsertedSpaceRef, args: (gesture, action))
    }
}
#endif
