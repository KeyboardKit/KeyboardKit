//
//  UITextDocumentProxy+DeleteTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

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
                let delete = proxy.recorder.executions(of: proxy.deleteBackward)
                expect(delete.count).to(equal(11))
            }
        }
    }
}
