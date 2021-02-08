//
//  AudioFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
@testable import KeyboardKit

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
                let calls = player.calls(to: player.playSystemAudioRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments).to(equal(123))
                expect(calls[1].arguments).to(equal(124))
            }
        }
    }
}


private class MockPlayer: Mock, SystemAudioPlayer {
    
    lazy var playSystemAudioRef = MockReference(playSystemAudio)
    
    func playSystemAudio(_ id: UInt32) {
        invoke(playSystemAudioRef, args: (id))
    }
}
