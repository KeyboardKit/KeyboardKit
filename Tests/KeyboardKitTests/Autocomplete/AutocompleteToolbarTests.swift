//
//  AutocompleteToolbarTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
@testable import KeyboardKit

class AutocompleteToolbarTests: QuickSpec {
    
    override func spec() {
        
        var inputViewController: MockInputViewController!
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            inputViewController = MockInputViewController()
            proxy = MockTextDocumentProxy()
            inputViewController.textDocumentProxyReplacement = proxy
            KeyboardInputViewController.shared = inputViewController
        }
        
        describe("standard replacement") {
            
            func result(for text: String) -> String {
                let suggestion = StandardAutocompleteSuggestion(text)
                return AutocompleteToolbar.standardReplacement(for: suggestion)
            }
            
            it("adds a space when needed") {
                expect(result(for: "Hello")).to(equal("Hello "))
            }
            
            it("does not add an additional space if the suggestion replacement ends with one") {
                expect(result(for: "Hello ")).to(equal("Hello "))
            }
            
            it("does not add an additional space if the text after the input starts with one") {
                proxy.documentContextBeforeInput = " world!"
                expect(result(for: "Hello ")).to(equal("Hello "))
            }
        }
    }
}
