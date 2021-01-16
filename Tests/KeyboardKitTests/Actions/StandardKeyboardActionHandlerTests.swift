//
//  StandardKeyboardActionHandlerTests.swift
//  KeyboardKitTests
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
    
    override func spec() {
        
        var handler: StandardKeyboardActionHandlerTestClass!
        
        var inputViewController: MockInputViewController!
        var keyboardContext: MockKeyboardContext!
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            inputViewController = MockInputViewController()
            keyboardContext = MockKeyboardContext()
            inputViewController.context = keyboardContext
            proxy = MockTextDocumentProxy()
            keyboardContext.textDocumentProxy = proxy
            handler = StandardKeyboardActionHandlerTestClass(inputViewController: inputViewController)
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
                expect(handler.hasInvoked(handler.triggerAnimationRef)).to(beTrue())
                expect(handler.hasInvoked(handler.triggerAudioFeedbackRef)).to(beTrue())
                expect(handler.hasInvoked(handler.triggerHapticFeedbackRef)).to(beTrue())
                expect(handler.hasInvoked(handler.triggerAutocompleteRef)).to(beTrue())
                expect(handler.hasInvoked(handler.tryChangeKeyboardTypeRef)).to(beTrue())
                expect(handler.hasInvoked(handler.tryEndSentenceRef)).to(beTrue())
                expect(handler.hasInvoked(handler.tryRegisterEmojiRef)).to(beTrue())
            }
        }
        
        
        // MARK: - Actions
        
        context("actions") {
            
            let actions = KeyboardAction.testActions
            
            describe("tap action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.tapAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardTapAction == nil))
                    }
                }
            }
            
            describe("double tap action") {
                
                it("is nil for all actions with standard action") {
                    actions.forEach {
                        expect(handler.doubleTapAction(for: $0, sender: nil)).to(beNil())
                    }
                }
            }
            
            describe("long press action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.longPressAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardLongPressAction == nil))
                    }
                }
            }
            
            describe("repeat action") {
                
                it("is not nil for actions with standard action") {
                    actions.forEach {
                        let action = handler.repeatAction(for: $0, sender: nil)
                        expect(action == nil).to(equal($0.standardRepeatAction == nil))
                    }
                }
            }
        }
        
        
        // MARK: - Action Handling
        
        describe("triggering animation for gesture on action") {
            // TODO: Test
        }
        
        describe("triggering audio feedback for gesture on action") {
            
            it("can't be properyly tested") {
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .backspace, sender: nil)
                handler.triggerAudioFeedback(for: .tap, on: .dismissKeyboard, sender: nil)
                // TODO Test this
            }
        }
        
        describe("triggering autocomplete") {
            
            it("calls input view controller") {
                expect(inputViewController.hasInvoked(inputViewController.performAutocompleteRef)).to(beFalse())
                handler.triggerAutocomplete()
                expect(inputViewController.hasInvoked(inputViewController.performAutocompleteRef)).to(beTrue())
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
                expect(handler.hasInvoked(handler.handleRef)).to(beFalse())
            }
            
            it("ends sentence with behavior action if behavior says yes") {
                proxy.documentContextBeforeInput = "foo  "
                handler.tryEndSentence(after: .tap, on: .character(" "))
                expect(proxy.hasInvoked(proxy.deleteBackwardRef, numberOfTimes: 2)).to(beTrue())
                expect(proxy.hasInvoked(proxy.insertTextRef, numberOfTimes: 1)).to(beTrue())
            }
        }
        
        describe("trying to change keyboard type after gesture on action") {
            
            it("does not change type if new type is same as current") {
                keyboardContext.keyboardType = .alphabetic(.lowercased)
                handler.tryChangeKeyboardType(after: .tap, on: .character("a"))
                expect(inputViewController.hasInvoked(inputViewController.changeKeyboardTypeRef)).to(beFalse())
            }
            
            it("changes type if new type is different from current") {
                keyboardContext.keyboardType = .alphabetic(.uppercased)
                handler.tryChangeKeyboardType(after: .tap, on: .character("a"))
                let inv = inputViewController.invokations(of: inputViewController.changeKeyboardTypeRef)
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
                handler.tryRegisterEmoji(after: .doubleTap, on: .emoji("a"))
                expect(mockProvider.hasInvoked(mockProvider.registerEmojiRef)).to(beFalse())
            }
            
            it("aborts if action is not emoji") {
                handler.tryRegisterEmoji(after: .tap, on: .space)
                expect(mockProvider.hasInvoked(mockProvider.registerEmojiRef)).to(beFalse())
            }
            
            it("registers tapped emoji to emoji category provider") {
                handler.tryRegisterEmoji(after: .tap, on: .emoji("a"))
                expect(mockProvider.hasInvoked(mockProvider.registerEmojiRef)).to(beTrue())
            }
        }
    }
}


private class StandardKeyboardActionHandlerTestClass: StandardKeyboardActionHandler, Mockable {
    
    public init(
        inputViewController: KeyboardInputViewController) {
        super.init(inputViewController: inputViewController)
    }
    
    var mock = Mock()
    
    lazy var handleRef = MockReference(handle)
    lazy var triggerAnimationRef = MockReference(triggerAnimation)
    lazy var triggerAudioFeedbackRef = MockReference(triggerAudioFeedback)
    lazy var triggerAutocompleteRef = MockReference(triggerAutocomplete)
    lazy var triggerHapticFeedbackRef = MockReference(triggerHapticFeedback)
    lazy var tryChangeKeyboardTypeRef = MockReference(tryChangeKeyboardType)
    lazy var tryEndSentenceRef = MockReference(tryEndSentence)
    lazy var tryRegisterEmojiRef = MockReference(tryRegisterEmoji)
    
    override func handle(_ gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.handle(gesture, on: action, sender: sender)
        invoke(handleRef, args: (gesture, action, sender))
    }
    
    override func triggerAnimation(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.triggerAnimation(for: gesture, on: action, sender: sender)
        invoke(triggerAnimationRef, args: (gesture, action, sender))
    }
    
    override func triggerAudioFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.triggerAudioFeedback(for: gesture, on: action, sender: sender)
        invoke(triggerAudioFeedbackRef, args: (gesture, action, sender))
    }
    
    override func triggerAutocomplete() {
        super.triggerAutocomplete()
        invoke(triggerAutocompleteRef, args: ())
    }
    
    override func triggerHapticFeedback(for gesture: KeyboardGesture, on action: KeyboardAction, sender: Any?) {
        super.triggerHapticFeedback(for: gesture, on: action, sender: sender)
        invoke(triggerHapticFeedbackRef, args: (gesture, action, sender))
    }
    
    override func tryChangeKeyboardType(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryChangeKeyboardType(after: gesture, on: action)
        invoke(tryChangeKeyboardTypeRef, args: (gesture, action))
    }
    
    override func tryEndSentence(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryEndSentence(after: gesture, on: action)
        invoke(tryEndSentenceRef, args: (gesture, action))
    }
    
    override func tryRegisterEmoji(after gesture: KeyboardGesture, on action: KeyboardAction) {
        super.tryRegisterEmoji(after: gesture, on: action)
        invoke(tryRegisterEmojiRef, args: (gesture, action))
    }
}
