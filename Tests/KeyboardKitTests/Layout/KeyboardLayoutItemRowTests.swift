//
//  KeyboardLayoutItemRowTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import SwiftUI
@testable import KeyboardKit

class KeyboardLayoutItemRowTests: QuickSpec {
    
    override func spec() {
        
        var row: KeyboardLayoutItemRow!
        var item: KeyboardLayoutItem!
        
        beforeEach {
            let size = KeyboardLayoutItemSize(width: .available, height: 100)
            let insets = EdgeInsets()
            item = KeyboardLayoutItem(action: .done, size: size, insets: insets)
            let item1 = KeyboardLayoutItem(action: .command, size: size, insets: insets)
            let item2 = KeyboardLayoutItem(action: .space, size: size, insets: insets)
            let item3 = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
            row = [item1, item2, item3]
        }
        
        var rowActions: KeyboardActionRow {
            row.map { $0.action }
        }
        
        describe("inserting item after action") {
            
            it("aborts if item is not found") {
                row.insert(item, after: .escape)
                expect(rowActions).to(equal([.command, .space, .backspace]))
            }
            
            it("can insert item after first") {
                row.insert(item, after: .command)
                expect(rowActions).to(equal([.command, .done, .space, .backspace]))
            }
            
            it("can insert item after last") {
                row.insert(item, after: .backspace)
                expect(rowActions).to(equal([.command, .space, .backspace, .done]))
            }
        }
        
        describe("inserting item before action") {
            
            it("aborts if item is not found") {
                row.insert(item, before: .escape)
                expect(rowActions).to(equal([.command, .space, .backspace]))
            }
            
            it("can insert item before first") {
                row.insert(item, before: .command)
                expect(rowActions).to(equal([.done, .command, .space, .backspace]))
            }
            
            it("can insert item before last") {
                row.insert(item, before: .backspace)
                expect(rowActions).to(equal([.command, .space, .done, .backspace]))
            }
        }
    }
}
