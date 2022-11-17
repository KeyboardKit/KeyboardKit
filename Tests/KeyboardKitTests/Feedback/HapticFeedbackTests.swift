//
//  HapticFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Quick
import Nimble
import KeyboardKit

class HapticFeedbackTests: QuickSpec {
    
    override func spec() {
        
        var engine: MockHapticFeedbackEngine!
        
        beforeEach {
            engine = MockHapticFeedbackEngine()
            HapticFeedback.engine = engine
        }
        
        describe("preparing feedback") {
            
            it("uses the shared audio engine") {
                HapticFeedback.success.prepare()
                HapticFeedback.warning.prepare()
                let calls = engine.calls(to: engine.prepareRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments).to(equal(.success))
                expect(calls[1].arguments).to(equal(.warning))
            }
        }
        
        describe("triggering feedback") {
            
            it("uses the shared audio engine") {
                HapticFeedback.success.trigger()
                HapticFeedback.warning.trigger()
                let calls = engine.calls(to: engine.triggerRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments).to(equal(.success))
                expect(calls[1].arguments).to(equal(.warning))
            }
        }
    }
}
#endif
