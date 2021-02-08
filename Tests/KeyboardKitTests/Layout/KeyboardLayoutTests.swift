//
//  KeyboardLayoutTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

class KeyboardLayoutTests: QuickSpec {
    
    override func spec() {
        
        describe("input width") {
            
            func item(_ width: KeyboardLayoutItemWidth) -> KeyboardLayoutItem {
                let size = KeyboardLayoutItemSize(width: width, height: 0)
                let item = KeyboardLayoutItem(action: .none, size: size, insets: .init())
                return item
            }
            
            it("returns 0 if no items exists") {
                let layout = KeyboardLayout(items: [])
                expect(layout.inputWidth(for: 123)).to(equal(0))
            }
            
            it("returns cache if a cached result exists") {
                let layout = KeyboardLayout(items: [])
                layout.widthCache[123] = 456
                expect(layout.inputWidth(for: 123)).to(equal(456))
            }
            
            it("input width has precedence over available width") {
                let layout = KeyboardLayout(items: [[
                    item(.available),
                    item(.input),
                    item(.input),
                    item(.available)
                ]])
                let result = layout.inputWidth(for: 200)
                expect(result).to(equal(100))
            }
            
            it("percentage width has precedence over input width") {
                let layout = KeyboardLayout(items: [[
                    item(.percentage(0.2)),
                    item(.input),
                    item(.input),
                    item(.percentage(0.2))
                ]])
                let result = layout.inputWidth(for: 200)
                expect(result).to(equal(60))
            }
            
            it("fixed width has precedence over input width") {
                let layout = KeyboardLayout(items: [[
                    item(.points(50)),
                    item(.input),
                    item(.input),
                    item(.points(50))
                ]])
                let result = layout.inputWidth(for: 200)
                expect(result).to(equal(50))
            }
            
            it("input percentage contribute to input width") {
                let layout = KeyboardLayout(items: [[
                    item(.points(50)),
                    item(.inputPercentage(0.6)),
                    item(.input),
                    item(.points(50))
                ]])
                let result = layout.inputWidth(for: 200)
                expect(result).to(equal(62.5))
            }
        }
    }
}
