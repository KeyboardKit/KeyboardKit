//
//  AudioFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import Mockery

class AudioFeedbackTest: QuickSpec {
    
    override func spec() {
        
        describe("audio feedback") {
            
            func value(for feedback: AudioFeedback) -> UInt32? {
                feedback.systemId
            }
            
            it("if has valid system id") {
                expect(value(for: .input)).to(equal(1104))
                expect(value(for: .system)).to(equal(1156))
                expect(value(for: .delete)).to(equal(1155))
                expect(value(for: .custom(id: 123))).to(equal(123))
                expect(value(for: .none)).to(beNil())
            }
        }
        
        describe("triggering feedback") {
            
            it("works both with static and instance approach") {
                let player = MockPlayer()
                AudioFeedback.systemPlayer = player
                AudioFeedback.trigger(.custom(id: 123))
                AudioFeedback.custom(id: 124).trigger()
                let exec = player.invokations(of: player.playSystemAudio)
                expect(exec.count).to(equal(2))
                expect(exec[0].arguments).to(equal(123))
                expect(exec[1].arguments).to(equal(124))
            }
        }
    }
}


private class MockPlayer: Mock, SystemAudioPlayer {
    
    func playSystemAudio(_ id: UInt32) {
        invoke(playSystemAudio, args: (id))
    }
}
