//
//  UITextDocumentProxy+DeleteTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit

class UITextDocumentProxy_DeleteTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        var delimiters: [String] { return proxy.wordDelimiters }
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        
        describe("deleting backwards certain number of times") {
            
            it("calls delete backwards correct number of times") {
                proxy.deleteBackward(times: 11)
                let delete = proxy.calls(to: proxy.deleteBackwardRef)
                expect(delete.count).to(equal(11))
            }
        }
    }
}
