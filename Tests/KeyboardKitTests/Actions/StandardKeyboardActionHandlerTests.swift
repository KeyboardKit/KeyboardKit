//
//  StandardKeyboardActionHandlerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import KeyboardKit
import UIKit

class StandardKeyboardActionHandlerTests: QuickSpec {
    
    var mock: Mock!
    func autocompleteAction() { mock.call(autocompleteActionRef, args: ()) }
    func changeKeyboardTypeAction(_ type: KeyboardType) { mock.call(changeKeyboardTypeActionRef, args: (type))  }
    lazy var autocompleteActionRef = MockReference(autocompleteAction)
    lazy var changeKeyboardTypeActionRef = MockReference(changeKeyboardTypeAction)

    override func spec() {
        
        var handler: TestClass!
        var feedbackHandler: MockKeyboardFeedbackHandler!
        var inputViewController: MockKeyboardInputViewController!
        var proxy: MockTextDocumentProxy!
        var spaceDragHandler: MockDragGestureHandler!
        
        beforeEach {
            self.mock = Mock()
            feedbackHandler = MockKeyboardFeedbackHandler()
            inputViewController = MockKeyboardInputViewController()
            proxy = MockTextDocumentProxy()
            inputViewController.keyboardContext.textDocumentProxy = proxy
            spaceDragHandler = MockDragGestureHandler()
            handler = TestClass(
                keyboardContext: inputViewController.keyboardContext,
                keyboardBehavior: inputViewController.keyboardBehavior,
                keyboardFeedbackHandler: feedbackHandler,
                autocompleteContext: inputViewController.autocompleteContext,
                autocompleteAction: self.autocompleteAction,
                changeKeyboardTypeAction: self.changeKeyboardTypeAction,
                spaceDragGestureHandler: spaceDragHandler)
        }


        // MARK: - KeyboardActionHandler

        describe("can handle gesture on action") {

            it("can handle any action that isn't nil") {
                expect(handler.canHandle(.tap, on: .backspace)).to(beTrue())
                expect(handler.canHandle(.doubleTap, on: .backspace)).to(beFalse())
            }
        }
        
        describe("handling gesture on action") {
            
            it("tap triggers a bunch of actions") {
                handler.handle(.tap, on: .character("a"))
                expect(self.mock.hasCalled(self.autocompleteActionRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryChangeKeyboardTypeRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryEndSentenceRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryRegisterEmojiRef)).to(beTrue())
                expect(feedbackHandler.hasCalled(feedbackHandler.triggerFeedbackWithActionProviderRef)).to(beTrue())
            }
        }
        
        describe("handling drag on action") {
            
            it("uses space drag handler for space") {
                handler.handleDrag(on: .space, from: .init(x: 1, y: 2), to: .init(x: 3, y: 4))
                let calls = spaceDragHandler.calls(to: spaceDragHandler.handleDragGestureRef)
                expect(calls.count).to(equal(1))
                expect(calls[0].arguments.0).to(equal(CGPoint.init(x: 1, y: 2)))
                expect(calls[0].arguments.1).to(equal(CGPoint.init(x: 3, y: 4)))
            }
            
            it("doesn't do anything for other actions") {
                let actions = KeyboardAction.testActions.filter { $0 != .space }
                actions.forEach {
                    handler.handleDrag(on: $0, from: .zero, to: .zero)
                }
                expect(spaceDragHandler.hasCalled(spaceDragHandler.handleDragGestureRef)).to(beFalse())
            }
        }


        // MARK: - Open Functions
        
        describe("action for gesture on action") {

            it("is nil for all actions with standard action") {
                KeyboardAction.testActions.forEach { action in
                    KeyboardGesture.allCases.forEach { gesture in
                        let res = handler.action(for: gesture, on: action)
                        expect(res == nil).to(equal(action.standardAction(for: gesture) == nil))
                    }
                }
            }
        }
        
        describe("replacement action for gesture on action") {

            it("is nil if gesture is not tap") {
                let res = handler.replacementAction(for: .press, on: .character("”"))
                expect(res).to(beNil())
            }
            
            it("is nil if action is not char") {
                let res = handler.replacementAction(for: .tap, on: .backspace)
                expect(res).to(beNil())
            }
            
            it("is nil if proxy has no preferred replacement") {
                let res = handler.replacementAction(for: .tap, on: .character("A"))
                expect(res).to(beNil())
            }
            
            it("is preferred replacement for tap on a valid char action") {
                let res = handler.replacementAction(for: .tap, on: .character("”"))
                expect(res).toNot(beNil())
            }
        }
        
        describe("trigger feedback for gesture on action") {

            it("calls injected feedback handler") {
                handler.triggerFeedback(for: .doubleTap, on: .backspace)
                handler.triggerFeedback(for: .release, on: .return)
                let calls = feedbackHandler.calls(to: feedbackHandler.triggerFeedbackWithActionProviderRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments.0).to(equal(.doubleTap))
                expect(calls[0].arguments.1).to(equal(.backspace))
                expect(calls[1].arguments.0).to(equal(.release))
                expect(calls[1].arguments.1).to(equal(.return))
            }
        }
        
        describe("trying to apply autocomplete suggestion before gesture on action") {
            
            beforeEach {
                let suggestion = StandardAutocompleteSuggestion("", isAutocomplete: true, isUnknown: false)
                proxy.documentContextBeforeInput = "abc"
                handler.autocompleteContext.suggestions = [suggestion]
            }

            it("aborts if gesture is not tap") {
                handler.tryApplyAutocompleteSuggestion(before: .press, on: .space)
                expect(proxy.hasCalled(proxy.adjustTextPositionRef)).to(beFalse())
            }
            
            it("aborts if action should not apply autocomplete") {
                handler.tryApplyAutocompleteSuggestion(before: .tap, on: .backspace)
                expect(proxy.hasCalled(proxy.adjustTextPositionRef)).to(beFalse())
            }
            
            it("aborts if autocomplete context has no valid suggestion") {
                handler.autocompleteContext.suggestions = []
                handler.tryApplyAutocompleteSuggestion(before: .tap, on: .space)
                expect(proxy.hasCalled(proxy.adjustTextPositionRef)).to(beFalse())
            }
            
            it("inserts autocomplete suggestion if everything is valid") {
                handler.tryApplyAutocompleteSuggestion(before: .tap, on: .space)
                let calls = proxy.calls(to: proxy.adjustTextPositionRef)
                expect(calls.count).to(equal(1))
            }
        }
        
        describe("trying to end sentence after gesture on action") {

            it("does not end sentence if behavior says no") {
                proxy.documentContextBeforeInput = ""
                handler.tryEndSentence(after: .tap, on: .character("a"))
                expect(handler.hasCalled(handler.handleRef)).to(beFalse())
            }

            it("ends sentence with behavior action if behavior says yes") {
                proxy.documentContextBeforeInput = "foo  "
                handler.tryEndSentence(after: .tap, on: .space)
                expect(proxy.hasCalled(proxy.deleteBackwardRef, numberOfTimes: 2)).to(beTrue())
                expect(proxy.hasCalled(proxy.insertTextRef, numberOfTimes: 1)).to(beTrue())
            }
        }
        
        describe("try to handle replacement action before gesture on action") {

            it("returns false if proxy has no preferred replacement") {
                let res = handler.tryHandleReplacementAction(before: .tap, on: .character("A"))
                expect(res).to(beFalse())
            }
            
            it("returns true for tap on a valid char action") {
                let res = handler.tryHandleReplacementAction(before: .tap, on: .character("”"))
                expect(res).to(beTrue())
            }
        }
        
        describe("trying to register emoji after gesture on action") {

            var mockProvider: MockFrequentEmojiProvider!

            beforeEach {
                mockProvider = MockFrequentEmojiProvider()
                EmojiCategory.frequentEmojiProvider = mockProvider
            }

            it("aborts if gesture is not tap") {
                handler.tryRegisterEmoji(after: .doubleTap, on: .emoji(Emoji("a")))
                expect(mockProvider.hasCalled(mockProvider.registerEmojiRef)).to(beFalse())
            }

            it("aborts if action is not emoji") {
                handler.tryRegisterEmoji(after: .tap, on: .space)
                expect(mockProvider.hasCalled(mockProvider.registerEmojiRef)).to(beFalse())
            }

            it("registers tapped emoji to emoji category provider") {
                handler.tryRegisterEmoji(after: .tap, on: .emoji(Emoji("a")))
                expect(mockProvider.hasCalled(mockProvider.registerEmojiRef)).to(beTrue())
            }
        }
        
        describe("trying to reinsert an autocomplete removed space after gesture on action") {
            
            beforeEach {
                proxy.documentContextBeforeInput = "hi"
                proxy.documentContextAfterInput = "you"
                proxy.tryInsertSpaceAfterAutocomplete()
                proxy.documentContextBeforeInput = "hi "
                proxy.tryRemoveAutocompleteInsertedSpace()
                proxy.resetCalls()
            }

            it("aborts if the gesture is not tap") {
                handler.tryReinsertAutocompleteRemovedSpace(after: .press, on: .character(","))
                expect(proxy.hasCalled(proxy.insertTextRef)).to(beFalse())
            }
            
            it("aborts if the action should not reinsert") {
                handler.tryReinsertAutocompleteRemovedSpace(after: .tap, on: .character("A"))
                expect(proxy.hasCalled(proxy.insertTextRef)).to(beFalse())
            }
            
            it("tells the proxy to reinsert auto-removed space if the gesture and action is valid") {
                handler.tryReinsertAutocompleteRemovedSpace(after: .tap, on: .character(","))
                expect(proxy.hasCalled(proxy.insertTextRef)).to(beTrue())
            }
        }
        
        describe("trying to remove an autocomplete inserted space before gesture on action") {
            
            beforeEach {
                proxy.documentContextBeforeInput = "hi"
                proxy.documentContextAfterInput = "you"
                proxy.tryInsertSpaceAfterAutocomplete()
                proxy.documentContextBeforeInput = "hi "
            }

            it("aborts if the gesture is not tap") {
                handler.tryRemoveAutocompleteInsertedSpace(before: .press, on: .character(","))
                expect(proxy.hasCalled(proxy.deleteBackwardRef)).to(beFalse())
            }
            
            it("aborts if the action should not remove") {
                handler.tryRemoveAutocompleteInsertedSpace(before: .tap, on: .character("A"))
                expect(proxy.hasCalled(proxy.deleteBackwardRef)).to(beFalse())
            }
            
            it("tells the proxy to remove auto-inserted space if the gesture and action is valid") {
                handler.tryRemoveAutocompleteInsertedSpace(before: .tap, on: .character(","))
                expect(proxy.hasCalled(proxy.deleteBackwardRef)).to(beTrue())
            }
        }
    }
}


private class TestClass: StandardKeyboardActionHandler, Mockable {

    var mock = Mock()

    lazy var handleRef = MockReference(handle as (KeyboardGesture, KeyboardAction) -> Void)
    lazy var tryChangeKeyboardTypeRef = MockReference(tryChangeKeyboardType)
    lazy var tryEndSentenceRef = MockReference(tryEndSentence)
    lazy var tryRegisterEmojiRef = MockReference(tryRegisterEmoji)

    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction) {
        super.handle(gesture, on: action)
        call(handleRef, args: (gesture, action))
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
}
