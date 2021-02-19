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
        var inputViewController: MockKeyboardInputViewController!
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            self.mock = Mock()
            inputViewController = MockKeyboardInputViewController()
            proxy = MockTextDocumentProxy()
            inputViewController.keyboardContext.textDocumentProxy = proxy
            handler = TestClass(
                keyboardContext: inputViewController.keyboardContext,
                keyboardBehavior: inputViewController.keyboardBehavior,
                autocompleteAction: self.autocompleteAction,
                changeKeyboardTypeAction: self.changeKeyboardTypeAction)
        }


        // MARK: - KeyboardActionHandler

        describe("can handle gesture on action") {

            it("can handle any action that isn't nil") {
                expect(handler.canHandle(.tap, on: .backspace, sender: nil)).to(beTrue())
                expect(handler.canHandle(.doubleTap, on: .backspace, sender: nil)).to(beFalse())
            }
        }

        describe("handling gesture on action") {

            it("performs a bunch of actions") {
                handler.handle(.tap, on: .character("a"))
                // let inv = proxy.invokations(of: proxy.insertTextRef)
                // expect(inv.count).to(equal(1))
                // expect(inv[0].arguments).to(equal("a"))
                expect(self.mock.hasCalled(self.autocompleteActionRef)).to(beTrue())
                expect(handler.hasCalled(handler.triggerAudioFeedbackRef)).to(beTrue())
                expect(handler.hasCalled(handler.triggerHapticFeedbackRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryChangeKeyboardTypeRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryEndSentenceRef)).to(beTrue())
                expect(handler.hasCalled(handler.tryRegisterEmojiRef)).to(beTrue())
            }
        }


        // MARK: - Actions

        context("action for gesture on action") {

            let actions = KeyboardAction.testActions

            describe("double tap action") {

                it("is nil for all actions with standard action") {
                    actions.forEach {
                        let action = handler.action(for: .doubleTap, on: $0)
                        expect(action == nil).to(equal($0.standardDoubleTapAction == nil))
                    }
                }
            }

            describe("long press action") {

                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.action(for: .longPress, on: $0)
                        expect(action == nil).to(equal($0.standardLongPressAction == nil))
                    }
                }
            }

            describe("tap action") {

                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.action(for: .tap, on: $0)
                        expect(action == nil).to(equal($0.standardTapAction == nil))
                    }
                }
            }

            describe("repeat action") {

                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.action(for: .repeatPress, on: $0)
                        expect(action == nil).to(equal($0.standardRepeatAction == nil))
                    }
                }
            }
        }


        // MARK: - Action Handling

        describe("triggering audio feedback for gesture on action") {

            it("can't be properyly tested") {
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .backspace, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                // TODO Test this
            }
        }

        describe("triggering haptic feedback") {

            it("can't be properyly tested") {
                handler.triggerHapticFeedback(for: .longPress, on: .dismissKeyboard, sender: nil)
                handler.triggerHapticFeedback(for: .repeatPress, on: .backspace, sender: nil)
                handler.triggerHapticFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                // TODO Test this
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

        describe("trying to change keyboard type after gesture on action") {

            it("does not change type if new type is same as current") {
                inputViewController.keyboardContext.keyboardType = .alphabetic(.lowercased)
                handler.tryChangeKeyboardType(after: .tap, on: .character("a"))
                expect(inputViewController.hasCalled(inputViewController.changeKeyboardTypeRef)).to(beFalse())
            }

            it("changes type if new type is different from current") {
                inputViewController.keyboardContext.keyboardType = .alphabetic(.uppercased)
                handler.tryChangeKeyboardType(after: .tap, on: .character("a"))
                let inv = self.mock.calls(to: self.changeKeyboardTypeActionRef)
                expect(inv.count).to(equal(1))
                expect(inv[0].arguments).to(equal(.alphabetic(.lowercased)))
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
    }
}


private class TestClass: StandardKeyboardActionHandler, Mockable {

    var mock = Mock()

    lazy var handleRef = MockReference(handle)
    lazy var triggerAudioFeedbackRef = MockReference(triggerAudioFeedback)
    lazy var triggerHapticFeedbackRef = MockReference(triggerHapticFeedback)
    lazy var tryChangeKeyboardTypeRef = MockReference(tryChangeKeyboardType)
    lazy var tryEndSentenceRef = MockReference(tryEndSentence)
    lazy var tryRegisterEmojiRef = MockReference(tryRegisterEmoji)

    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
        call(handleRef, args: (gesture, action, sender))
    }

    override func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.triggerAudioFeedback(for: gesture, on: action, sender: sender)
        call(triggerAudioFeedbackRef, args: (gesture, action, sender))
    }

    override func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.triggerHapticFeedback(for: gesture, on: action, sender: sender)
        call(triggerHapticFeedbackRef, args: (gesture, action, sender))
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
