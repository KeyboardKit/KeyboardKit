//
//  Image+KeyboardTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKitSwiftUI
import SwiftUI

class Image_KeyboardTests: QuickSpec {
    
    override func spec() {
        
        describe("keyboard images") {
            
            func result(for image: Image) -> Image { image }
            
            it("are defined") {
                expect(result(for: .backspace)).to(equal(Image(systemName: "delete.left")))
                expect(result(for: .dictation)).to(equal(Image(systemName: "mic")))
                expect(result(for: .command)).to(equal(Image(systemName: "command")))
                expect(result(for: .control)).to(equal(Image(systemName: "control")))
                expect(result(for: .email)).to(equal(Image(systemName: "envelope")))
                expect(result(for: .globe)).to(equal(Image(systemName: "globe")))
                expect(result(for: .images)).to(equal(Image(systemName: "photo")))
                expect(result(for: .keyboard)).to(equal(Image(systemName: "keyboard")))
                expect(result(for: .keyboardDismiss)).to(equal(Image(systemName: "keyboard.chevron.compact.down")))
                expect(result(for: .keyboardDismissLeft)).to(equal(Image(systemName: "keyboard.chevron.compact.left")))
                expect(result(for: .keyboardDismissRight)).to(equal(Image(systemName: "keyboard.chevron.compact.right")))
                expect(result(for: .moveCursorLeft)).to(equal(Image(systemName: "arrow.left")))
                expect(result(for: .moveCursorRight)).to(equal(Image(systemName: "arrow.right")))
                expect(result(for: .newLine)).to(equal(Image(systemName: "arrow.turn.down.left")))
                expect(result(for: .option)).to(equal(Image(systemName: "option")))
                expect(result(for: .redo)).to(equal(Image(systemName: "arrow.uturn.right")))
                expect(result(for: .shiftCapslocked)).to(equal(Image(systemName: "capslock.fill")))
                expect(result(for: .shiftLowercased)).to(equal(Image(systemName: "shift")))
                expect(result(for: .shiftUppercased)).to(equal(Image(systemName: "shift.fill")))
                expect(result(for: .tab)).to(equal(Image(systemName: "arrow.right.to.line")))
                expect(result(for: .undo)).to(equal(Image(systemName: "arrow.uturn.left")))
            }
            
            it("are restricted to iOS 14 for some images") {
                if #available(iOS 14, *) {
                    expect(result(for: .emoji)).to(equal(Image(systemName: "face.smiling")))
                }
            }
        }
    }
}
