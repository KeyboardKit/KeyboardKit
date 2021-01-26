//
//  AutocompleteToolbarTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2021-01-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

class AutocompleteToolbarTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        var context: MockKeyboardContext!
        var actionHandler: MockKeyboardActionHandler!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
            context = MockKeyboardContext()
            actionHandler = MockKeyboardActionHandler()
            context.actionHandler = actionHandler
            context.textDocumentProxy = proxy
        }
        
        describe("standard replacement") {
            
            it("adds a space when needed") {
                let result = AutocompleteToolbar.standardReplacement(for: "Hello", context: context)
                expect(result).to(equal("Hello "))
            }
            
            it("does not add an additional space if the suggestion replacement ends with one") {
                let result = AutocompleteToolbar.standardReplacement(for: "Hello ", context: context)
                expect(result).to(equal("Hello "))
            }
            
            it("does not add an additional space if the text after the input starts with one") {
                proxy.documentContextBeforeInput = " world!"
                let result = AutocompleteToolbar.standardReplacement(for: "Hello ", context: context)
                expect(result).to(equal("Hello "))
            }
        }
        
        describe("standard replacement action") {
            
            it("replaces current word in proxy") {
                proxy.documentContextBeforeInput = "abc"
                AutocompleteToolbar.standardReplacementAction(for: "Hello", context: context)
                let inv = proxy.invokations(of: proxy.insertTextRef)
                expect(inv.count).to(equal(1))
                expect(inv[0].arguments).to(equal("Hello "))
            }
            
            it("triggers action handler") {
                AutocompleteToolbar.standardReplacementAction(for: "Hello", context: context)
                let inv = actionHandler.invokations(of: actionHandler.handleRef)
                expect(inv.count).to(equal(1))
                expect(inv[0].arguments.0).to(equal(.tap))
                expect(inv[0].arguments.1).to(equal(.character("")))
            }
        }
    }
}
