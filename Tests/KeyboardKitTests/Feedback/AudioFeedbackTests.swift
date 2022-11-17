//
//  AudioFeedbackTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
import Quick
import Nimble
import KeyboardKit

class AudioFeedbackTests: QuickSpec {
    
    override func spec() {
        
        var player: MockAudioFeedbackPlayer!
        
        beforeEach {
            player = MockAudioFeedbackPlayer()
            AudioFeedback.player = player
        }
        
        describe("audio feedback") {
            
            func value(for feedback: AudioFeedback) -> UInt32? {
                feedback.id
            }
            
            it("if has valid system id") {
                expect(value(for: .input)).to(equal(1104))
                expect(value(for: .system)).to(equal(1156))
                expect(value(for: .delete)).to(equal(1155))
                expect(value(for: .custom(id: 123))).to(equal(123))
                expect(value(for: .none)).to(equal(0))
            }
        }
        
        describe("triggering feedback") {
            
            it("uses the shared audio player") {
                AudioFeedback.custom(id: 111).trigger()
                AudioFeedback.custom(id: 124).trigger()
                let calls = player.calls(to: player.playRef)
                expect(calls.count).to(equal(2))
                expect(calls[0].arguments.id).to(equal(111))
                expect(calls[1].arguments.id).to(equal(124))
            }
        }
    }
}
#endif
