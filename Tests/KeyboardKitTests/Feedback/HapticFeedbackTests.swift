//
//  HapticFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-04-01.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

#if os(iOS) || os(watchOS) || os(macOS)
class HapticFeedbackTests: QuickSpec {
    
    override func spec() {
        
        var player: MockHapticFeedbackPlayer!
        
        beforeEach {
            player = MockHapticFeedbackPlayer()
            StandardHapticFeedbackPlayer.shared = player
        }
        
        describe("preparing feedback") {
            
            it("uses the shared audio player") {
                HapticFeedback.success.prepare()
                HapticFeedback.warning.prepare()
                let calls = player.calls(to: player.prepareRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments).to(equal(.success))
                expect(calls[1].arguments).to(equal(.warning))
            }
        }
        
        describe("triggering feedback") {
            
            it("uses the shared audio player") {
                HapticFeedback.success.trigger()
                HapticFeedback.warning.trigger()
                let calls = player.calls(to: player.playRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments).to(equal(.success))
                expect(calls[1].arguments).to(equal(.warning))
            }
        }
    }
}
#endif
