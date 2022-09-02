//
//  KeyboardImageReaderTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardImageReaderTests: QuickSpec {
    
    override func spec() {
        
        describe("keyboard images") {
            
            func result(for image: Image) -> Image { image }
            
            it("are defined") {
                expect(result(for: .keyboardBackspace)).to(equal(Image(systemName: "delete.left")))
                expect(result(for: .keyboardBackspaceRtl)).to(equal(Image(systemName: "delete.right")))
                expect(result(for: .keyboardCommand)).to(equal(Image(systemName: "command")))
                expect(result(for: .keyboardControl)).to(equal(Image(systemName: "control")))
                expect(result(for: .keyboardDictation)).to(equal(Image(systemName: "mic")))
                expect(result(for: .keyboardEmail)).to(equal(Image(systemName: "envelope")))
                expect(result(for: .keyboardGlobe)).to(equal(Image(systemName: "globe")))
                expect(result(for: .keyboardImages)).to(equal(Image(systemName: "photo")))
                expect(result(for: .keyboard)).to(equal(Image(systemName: "keyboard")))
                expect(result(for: .keyboardDismiss)).to(equal(Image(systemName: "keyboard.chevron.compact.down")))
                expect(result(for: .keyboardLeft)).to(equal(Image(systemName: "arrow.left")))
                expect(result(for: .keyboardNewline)).to(equal(Image(systemName: "arrow.turn.down.left")))
                expect(result(for: .keyboardNewlineRtl)).to(equal(Image(systemName: "arrow.turn.down.right")))
                expect(result(for: .keyboardOption)).to(equal(Image(systemName: "option")))
                expect(result(for: .keyboardRedo)).to(equal(Image(systemName: "arrow.uturn.right")))
                expect(result(for: .keyboardRight)).to(equal(Image(systemName: "arrow.right")))
                expect(result(for: .keyboardSettings)).to(equal(Image(systemName: "gearshape.fill")))
                expect(result(for: .keyboardShiftCapslocked)).to(equal(Image(systemName: "capslock.fill")))
                expect(result(for: .keyboardShiftLowercased)).to(equal(Image(systemName: "shift")))
                expect(result(for: .keyboardShiftUppercased)).to(equal(Image(systemName: "shift.fill")))
                expect(result(for: .keyboardTab)).to(equal(Image(systemName: "arrow.right.to.line")))
                expect(result(for: .keyboardUndo)).to(equal(Image(systemName: "arrow.uturn.left")))
            }
            
            it("are restricted to iOS 14 for some images") {
                if #available(iOS 14, *) {
                    expect(result(for: .keyboardEmoji)).to(equal(Image(systemName: "face.smiling")))
                }
            }
        }
    }
}
